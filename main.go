package main

import (
	"github.com/hashicorp/packer/packer/plugin"
	"github.com/jamtur01/packer-post-processor-slacknotifications/plugin"
)

func main() {
	server, err := plugin.Server()
	if err != nil {
		panic(err)
	}
	server.RegisterPostProcessor(new(slacknotifications.PostProcessor))
	server.Serve()
}
