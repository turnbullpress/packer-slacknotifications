default: build

prepare:
	go get github.com/tools/godep
	godep restore
	go get ./...

test: prepare
	go test ./...

fmt:
	go fmt . ./plugin

build: fmt test
	go build -v

install: build
	mkdir -p ~/.packer.d/plugins
	install ./packer-post-processor-slack-notifications ~/.packer.d/plugins/

release: test
	go get github.com/mitchellh/gox
	gox --output 'dist/{{.OS}}_{{.Arch}}/{{.Dir}}'
	zip -j releases/packer-post-processor-slack-notifications_darwin_386.zip    dist/darwin_386/packer-post-processor-slack-notifications
	zip -j releases/packer-post-processor-slack-notifications_darwin_amd64.zip  dist/darwin_amd64/packer-post-processor-slack-notifications
	zip -j releases/packer-post-processor-slack-notifications_freebsd_386.zip   dist/freebsd_386/packer-post-processor-slack-notifications
	zip -j releases/packer-post-processor-slack-notifications_freebsd_amd64.zip dist/freebsd_amd64/packer-post-processor-slack-notifications
	zip -j releases/packer-post-processor-slack-notifications_freebsd_arm.zip   dist/freebsd_arm/packer-post-processor-slack-notifications
	zip -j releases/packer-post-processor-slack-notifications_linux_386.zip     dist/linux_386/packer-post-processor-slack-notifications
	zip -j releases/packer-post-processor-slack-notifications_linux_amd64.zip   dist/linux_amd64/packer-post-processor-slack-notifications
	zip -j releases/packer-post-processor-slack-notifications_linux_arm.zip     dist/linux_arm/packer-post-processor-slack-notifications
	zip -j releases/packer-post-processor-slack-notifications_netbsd_386.zip    dist/netbsd_386/packer-post-processor-slack-notifications
	zip -j releases/packer-post-processor-slack-notifications_netbsd_amd64.zip  dist/netbsd_amd64/packer-post-processor-slack-notifications
	zip -j releases/packer-post-processor-slack-notifications_netbsd_arm.zip    dist/netbsd_arm/packer-post-processor-slack-notifications
	zip -j releases/packer-post-processor-slack-notifications_openbsd_386.zip   dist/openbsd_386/packer-post-processor-slack-notifications
	zip -j releases/packer-post-processor-slack-notifications_openbsd_amd64.zip dist/openbsd_amd64/packer-post-processor-slack-notifications
	zip -j releases/packer-post-processor-slack-notifications_windows_386.zip   dist/windows_386/packer-post-processor-slack-notifications.exe
	zip -j releases/packer-post-processor-slack-notifications_windows_amd64.zip dist/windows_amd64/packer-post-processor-slack-notifications.exe

clean:
	rm -rf dist/
	rm -f releases/*.zip

.PHONY: default prepare test build install release clean
