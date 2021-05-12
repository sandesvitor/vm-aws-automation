package test

import (
	"fmt"
	"os"
	"strconv"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestAWSVpc(t *testing.T) {
	uniqueId := random.UniqueId()
	vpcName := fmt.Sprintf("vpc_testing-%s", uniqueId)

	awsRegion := aws.GetRandomStableRegion(t, nil, nil)

	terraformOptions := &terraform.Options{
		TerraformDir: "../modules/terraform-aws-network",
		Vars: map[string]interface{}{
			"vpc_name_tag":            vpcName,
			"main_network_block":      "192.168.0.0/16",
			"subnet_prefix_extension": 4,
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.Apply(t, terraformOptions)

	outputVpcCIDR := terraform.Output(t, terraformOptions, "vpc_cidr_block")

	assert.Equal(t, "192.168.0.0/16", outputVpcCIDR)
}

func TestPublicSubnets(t *testing.T) {
	uniqueId := random.UniqueId()
	subnetBaseName := fmt.Sprintf("subnet_testing-%s", uniqueId)

	awsRegion := aws.GetRandomStableRegion(t, nil, nil)
	azs := aws.GetAvailabilityZones(t, awsRegion)

	terraformOptions := &terraform.Options{
		TerraformDir: "../modules/terraform-aws-network",
		Vars: map[string]interface{}{
			"vpc_name_tag":            subnetBaseName,
			"main_network_block":      "192.168.0.0/16",
			"subnet_prefix_extension": 4,
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.Apply(t, terraformOptions)

	publicSubnetsCount := terraform.Output(t, terraformOptions, "public_subnets")
	i, err := strconv.Atoi(publicSubnetsCount)
	if err != nil {
		fmt.Println(err)
		os.Exit(2)
	}
	assert.Equal(t, len(azs), i)
}
