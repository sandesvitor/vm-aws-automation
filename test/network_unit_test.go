package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestAWSublicSubnetsUnit(t *testing.T) {
	uniqueId := random.UniqueId()
	subnetBaseName := fmt.Sprintf("subnet_testing-%s", uniqueId)

	awsRegion := aws.GetRandomStableRegion(t, nil, nil)
	azs := aws.GetAvailabilityZones(t, awsRegion)

	terraformOptions := &terraform.Options{
		TerraformDir: "../modules/terraform-aws-network",
		Vars: map[string]interface{}{
			"subnet_name_tag":         subnetBaseName,
			"main_network_block":      "192.168.0.0/16",
			"subnet_prefix_extension": 4,
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	vpcId := terraform.Output(t, terraformOptions, "vpc_id")
	subnets := aws.GetSubnetsForVpc(t, vpcId, awsRegion)
	publicSubnetsId := terraform.OutputList(t, terraformOptions, "public_subnets_id")

	require.Equal(t, len(azs), len(subnets))

	for _, subnet := range publicSubnetsId {
		assert.True(t, aws.IsPublicSubnet(t, subnet, awsRegion))
	}
}
