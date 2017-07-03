package main

import (
	"github.com/hashicorp/packer/packer/plugin"
	"github.com/turnbullpress/packer-slacknotifications"
)

func main() {
	server, err := plugin.Server()
	if err != nil {
		panic(err)
	}

	server.RegisterPostProcessor(new(slacknotifications.PostProcessor))
	server.Serve()
}
