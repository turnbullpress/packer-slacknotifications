# packer-slacknotifications

[![Build Status](https://travis-ci.org/turnbullpress/packer-slacknotifications.svg?branch=master)](https://travis-ci.org/turnbullpress/packer-slacknotifications)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

Packer post-processor plugin for Slack notifications

## Description
The Packer Slack Notification post-processor assists you in sending Slack notifications when a build is complete.

## Installation
Packer supports plugins. Please read document the following:  
https://www.packer.io/docs/extend/plugins.html

You can download binaries built for your architecture from [latest releases](https://github.com/turnbullpress/packer-slacknotifications/releases/latest).

## Usage
The following example `template.json`:

```
{
  "builders": [{
    "type": "amazon-ebs",
    "region": "us-east-1",
    "source_ami": "ami-6869aa05",
    "instance_type": "t2.micro",
    "ssh_username": "ec2-user",
    "ssh_pty": "true",
    "ami_name": "packer-example {{timestamp}}"
  }],
  "provisioners":[{
    "type": "shell",
    "inline": [
      "echo 'running...'"
    ]
  }],
  "post-processors":[{
    "type": "slack-notifications",
    "channel": "general",
    "url": "https://slackwebhook.url/slackwebhookid"
  }]
}
```

### Configuration

Type: `slack-notifications`

Required:
  - `channel` (string)
    - The channel to which to send the notification.
  - `url` (string)
    - The Slack Webhook URL

## Developing Plugin

If you wish to build this plugin on your environment, you can use GNU Make build system.  
But this Makefile depends on [Go](https://golang.org/). At First, you should install Go.  
And we use [godep](https://github.com/tools/godep) for dependency management. Please looks the [reference](https://godoc.org/github.com/tools/godep)

### Run Test
```
make test
go get github.com/tools/godep
godep restore
go get ./...
go test ./...
?       github.com/turnbullpress/packer-slacknotifications  [no test files]
?        github.com/turnbullpress/packer-slacknotifications/plugin   0.029s
```
Run the unit tests when developing changes to the plugin.

### Installation
```
make install
go get github.com/tools/godep
godep restore
go get ./...
go test ./...
?       github.com/turnbullpress/packer-slacknotifications  [no test files]
?       github.com/turnbullpress/packer-slacknotifications/plugin   0.023s
go build ./
mkdir -p ~/.packer.d/plugins
install ./packer-slacknotifications ~/.packer.d/plugins/
```
Run tests, build and move the compiled plugin to the plugin directory.

### Release
```
make release
go get github.com/tools/godep
godep restore
go get ./...
go test ./...
?       github.com/turnbullpress/packer-slacknotifications  [no test files]
github.com/turnbullpress/packer-slacknotifications/plugin   0.020s
...
go get github.com/mitchellh/gox
gox --output 'dist/{{.OS}}_{{.Arch}}/{{.Dir}}'
...
```

Run tests, build for each architecture and archive binaries.
