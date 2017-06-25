package slacknotifications

import (
	"fmt"
	"log"

  "github.com/hashicorp/packer/common"
  "github.com/hashicorp/packer/helper/config"
	"github.com/hashicorp/packer/packer"
	"github.com/hashicorp/packer/template/interpolate"
  "github.com/ashwanthkumar/slack-go-webhook"
)

type Config struct {
	common.PackerConfig `mapstructure:",squash"`

  Channel string `mapstructure:"channel"`
	Url     string `mapstructure:"url"`

	ctx interpolate.Context
}

type PostProcessor struct {
	config Config
}

func (p *PostProcessor) Configure(raws ...interface{}) error {
	err := config.Decode(&p.config, &config.DecodeOpts{
		Interpolate:        true,
		InterpolateContext: &p.config.ctx,
		InterpolateFilter: &interpolate.RenderFilter{
			Exclude: []string{},
		},
	}, raws...)
	if err != nil {
		return err
	}

  if len(p.config.Channel) == 0 {
		return fmt.Errorf("No channel specified in Slack configuration")
	}

  if len(p.config.Url) == 0 {
		return fmt.Errorf("No Webhook URL specified in Slack configuration")
	}

	return nil
}

func (p *PostProcessor) PostProcess(ui packer.Ui, artifact packer.Artifact) (packer.Artifact, bool, error) {
	log.Println("Sending Slack notification")

  webhookUrl := p.config.Url
	payload := slack.Payload {
    Text: artifact.String(),
    Username: "Packer",
    Channel: p.config.Channel,
    IconEmoji: ":monkey_face:",
  }
  err := slack.Send(webhookUrl, "", payload)
  if len(err) > 0 {
    fmt.Printf("error: %s\n", err)
  }

	return artifact, true, nil
}
