package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestAWSEC2Unit(t *testing.T) {
	t.Parallel()

	uniqueId := random.UniqueId()
	EC2Name := fmt.Sprintf("%s", uniqueId)

	awsRegion := "us-east-1"
	instanceType := aws.GetRecommendedInstanceType(t, awsRegion, []string{"t2.micro", "t3.micro"})

	terraformOptions := &terraform.Options{
		TerraformDir: "../../examples/ec2_simple_deploy",
		Vars: map[string]interface{}{
			"region":        awsRegion,
			"ec2_name_tag":  EC2Name,
			"instance_type": instanceType,
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	instancesStates := terraform.OutputList(t, terraformOptions, "state")

	for _, state := range instancesStates {
		assert.Equal(t, "running", state)
	}
}
