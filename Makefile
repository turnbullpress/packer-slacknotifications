default: build

prepare:
	go get github.com/tools/godep
	godep restore
	go get ./...

test: prepare
	go test ./...

fmt:
	go fmt . ./slacknotifications

build: fmt test
	go build -v

install: build
	mkdir -p ~/.packer.d/plugins
	install ./packer-slacknotifications ~/.packer.d/plugins/

release: test
	go get github.com/mitchellh/gox
	gox --output 'dist/{{.OS}}_{{.Arch}}/{{.Dir}}'
	zip -j releases/packer-slacknotifications_darwin_386.zip    dist/darwin_386/packer-slacknotifications
	zip -j releases/packer-slacknotifications_darwin_amd64.zip  dist/darwin_amd64/packer-slacknotifications
	zip -j releases/packer-slacknotifications_freebsd_386.zip   dist/freebsd_386/packer-slacknotifications
	zip -j releases/packer-slacknotifications_freebsd_amd64.zip dist/freebsd_amd64/packer-slacknotifications
	zip -j releases/packer-slacknotifications_freebsd_arm.zip   dist/freebsd_arm/packer-slacknotifications
	zip -j releases/packer-slacknotifications_linux_386.zip     dist/linux_386/packer-slacknotifications
	zip -j releases/packer-slacknotifications_linux_amd64.zip   dist/linux_amd64/packer-slacknotifications
	zip -j releases/packer-slacknotifications_linux_arm.zip     dist/linux_arm/packer-slacknotifications
	zip -j releases/packer-slacknotifications_netbsd_386.zip    dist/netbsd_386/packer-slacknotifications
	zip -j releases/packer-slacknotifications_netbsd_amd64.zip  dist/netbsd_amd64/packer-slacknotifications
	zip -j releases/packer-slacknotifications_netbsd_arm.zip    dist/netbsd_arm/packer-slacknotifications
	zip -j releases/packer-slacknotifications_openbsd_386.zip   dist/openbsd_386/packer-slacknotifications
	zip -j releases/packer-slacknotifications_openbsd_amd64.zip dist/openbsd_amd64/packer-slacknotifications
	zip -j releases/packer-slacknotifications_windows_386.zip   dist/windows_386/packer-slacknotifications.exe
	zip -j releases/packer-slacknotifications_windows_amd64.zip dist/windows_amd64/packer-slacknotifications.exe

clean:
	rm -rf dist/
	rm -f releases/*.zip

.PHONY: default prepare test build install release clean
