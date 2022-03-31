.PHONY: get-deps
get-deps:
	@echo "Getting test deps"
	go get github.com/gruntwork-io/terratest/modules/terraform
	go get github.com/gruntwork-io/terratest/modules/http-helper
	go get github.com/gruntwork-io/terratest
	go get github.com/aws/aws-sdk-go/aws
	go get github.com/stretchr/testify
	go get github.com/gruntwork-io/terratest/modules/ssh
	go get github.com/gruntwork-io/terratest/modules/aws

.PHONY: test
test:
	@echo "Running Terrates suit"
	go test -v -count=1 -timeout 30m -p 1 ./test/unit/

.PHONY: build-and-test
build-and-test: get-deps test