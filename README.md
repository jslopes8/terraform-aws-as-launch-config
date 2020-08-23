# Terraform module for create AWS Launch Configuration
Provider a launch configuration for autoscaling group.

The code will provide the following resources
* [Launch Configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration)

### Usage
Example of the use: Crianting launch configuration
```hcl
module "lb_bastion_config" {
    source = "git@github.com:jslopes8/terraform-aws-as-launch-config.git?ref=v2.0"

    # choose between launch configuration or launch template
    launch_configuration = "true"

    name            = "lc-name"
    security_groups = [ module.sgecurity_group.id ]
    
    key_name        = "key-ssh"
    user_data       = data.template_file.user_data.rendered

    instance_type   = "t2.small"

    # this example to choose ami amazon linux 2
    choose_ami = [
        {
            most_recent = "true"
            owners  = [ "amazon" ]
            filter = [
                {
                    name = "owner-alias"
                    values = [ "amazon" ]
                },
                {
                    name = "name"
                    values = ["amzn2-ami-hvm*"]
                }
            ]
        }
    ]
    root_block_device = [
        {
            volume_type           = "gp2"
            volume_size           = "30"
            delete_on_termination = "true"
        }
    ]
}
```

Example of the use: criating launch configuration with spot
```hcl
module "lb_bastion_config" {
    source = "git@github.com:jslopes8/terraform-aws-as-launch-config.git?ref=v2.0"

    # choose between launch configuration or launch template
    launch_configuration = "true"

    name            = "lc-name"
    security_groups = [ module.sgecurity_group.id ]
    
    # the maximum price to use for reserving spot instances.
    spot_price      = "0.001"
}
```

## Requirements
| Name | Version |
| ---- | ------- |
| aws | ~> 3.3 |
| terraform | 0.13 |

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Variables Inputs
| Name | Description | Required | Type | Default |
| ---- | ----------- | -------- | ---- | ------- |
| name | The name of the launch configuration. | `yes` | `string` | `` |
| launch_configuration | Choose per launch configuration. | `yes` | `bool` | `true` |
| security_groups | A list of associated security group IDS. | `yes` | `list` | `[]` |
| image_id | The EC2 image ID to launch. Do not use when `choose_ami` attribute is being used | `no` | `string` | `` |
| choose_ami | Use this data source to get the ID of a registered AMI for use in other resources. Do not use when `image_id` attribute is being used. | `no` | `any` | `[]` |
| root_block_device | Details about the root block device of the instance. | `yes` | `list` | `[]` |
| instance_type | The size of instance to launch. | `yes` | `string` | `` |
| iam_instance_profile | IAM instance profile to associate with launched instances. | `no` | `string` | `` |
| key_name | The key name that should be used for the instance. | `yes` | `string` | `` |

## Variable Outputs
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
| Name | Description |
| ---- | ----------- |
| name | The name of the launch configuration. |