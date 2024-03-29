.PHONY: get-deps
get-deps:
	@echo "##############################################################"
	@echo "Getting test deps"
	@echo "##############################################################"
	@echo ""
	@echo ""
	go get github.com/gruntwork-io/terratest/modules/terraform
	go get github.com/gruntwork-io/terratest/modules/http-helper
	go get github.com/gruntwork-io/terratest
	go get github.com/aws/aws-sdk-go/aws
	go get github.com/stretchr/testify
	go get github.com/gruntwork-io/terratest/modules/ssh
	go get github.com/gruntwork-io/terratest/modules/aws

.PHONY: test
test:
	@echo ""
	@echo ""
	@echo "##############################################################"
	@echo "Running Terratest tests suit"
	@echo "##############################################################"
	@echo ""
	@echo ""
	go test -v -count=1 -timeout 30m -parallel 10 ./test/unit/

.PHONY: build-and-test
build-and-test: get-deps test