package test

import (
	"fmt"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSEC2Unit(t *testing.T) {
	uniqueId := random.UniqueId()
	EC2Name := fmt.Sprintf("%s", uniqueId)

	awsRegion := aws.GetRandomStableRegion(t, nil, nil)
	instanceType := aws.GetRecommendedInstanceType(t, awsRegion, []string{"t2.micro", "t3.micro"})

	vpc := aws.GetDefaultVpc(t, awsRegion)
	subnets := aws.GetSubnetsForVpc(t, vpc.Id, awsRegion)
	amazonAMI := aws.GetAmazonLinuxAmi(t, awsRegion)

	subnetIds := make([]string, len(subnets))
	for i := 0; i < len(subnets); i++ {
		subnetIds[i] = subnets[i].Id
	}

	terraformOptions := &terraform.Options{
		TerraformDir: "../modules/terraform-aws-ec2",
		Vars: map[string]interface{}{
			"ec2_name_tag":  EC2Name,
			"subnet_ids":    subnetIds,
			"instance_type": instanceType,
			"ami":           amazonAMI,
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	publicIps := terraform.OutputList(t, terraformOptions, "public_ips")

	for _, ip := range publicIps {
		url := fmt.Sprintf("http://%s:8080", ip)
		http_helper.HttpGetWithRetry(t, url, nil, 200, "Hello, World!", 30, 5*time.Second)
	}
}
