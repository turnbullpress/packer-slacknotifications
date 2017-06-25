package slacknotifications

import (
	"fmt"
	"log"
	"time"

	"github.com/mitchellh/packer/common"
	"github.com/mitchellh/packer/helper/config"
	"github.com/mitchellh/packer/packer"
	"github.com/mitchellh/packer/template/interpolate"
  "github.com/bluele/slack"
)

const (
  token       = os.Getenv("SLACK_TOKEN")
  channelName = "general"
)

func (p *PostProcessor) PostProcess(ui packer.Ui, artifact packer.Artifact) (packer.Artifact, bool, error) {
	log.Println("Sending Slack notification")

  api := slack.New(token)
  err := api.ChatPostMessage(channelName, "Hello, world!", nil)
  if err != nil {
    panic(err)
  }
}
