package slacknotifications

import (
	"bytes"
	"testing"

	"github.com/hashicorp/packer/packer"
)

func testUi() *packer.BasicUi {
	return &packer.BasicUi{
		Reader: new(bytes.Buffer),
		Writer: new(bytes.Buffer),
	}
}

func TestPostProcessor_ImplementsPostProcessor(t *testing.T) {
	var _ packer.PostProcessor = new(PostProcessor)
}
