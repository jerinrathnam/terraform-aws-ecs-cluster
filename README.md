## Introduction

This Terraform module is for an AWS ECS Cluster. This module is designed to help users easily create an ECS cluster with some of its components like services, task definitions, container definitions in AWS Cloud Platform.

The AWS ECS (Elastic Container Service) cluster is a container orchestration service provided by AWS that allows users to deploy and manage containerized applications on the cloud. Terraform is an infrastructure-as-code tool that allows users to define and manage infrastructure resources in a declarative manner.

The AWS ECS cluster Terraform module is a pre-built Terraform configuration that enables users to easily provision and manage an ECS cluster on AWS. The module abstracts away many of the complexities of setting up and managing an ECS cluster, such as configuring VPCs, security groups, and IAM roles.

By using the AWS ECS cluster Terraform module, users can quickly and easily provision an ECS cluster on AWS with minimal configuration. The module abstracts away many of the lower-level details of the ECS service and provides a simplified interface for managing the cluster.


## Usage

### 1. Example code for ecs cluster with one service and task definition
```
  module "ecs" { 
  source  = "jerinrathnam/ecs-cluster/aws"

    cluster_name      = "my-cluster"
    name              = ["service-1"]
    port              = [80]
    security_groups   = ["sg-0123456789abcdef"]
    subnet_ids        = ["subnet-s123f7f546", "subnet-32g745g56"]

    tags = {
      "Env" = "test"
    }
  }
```

### 2. Example code for ecs cluster without ECR image or using docker image
```
  module "ecs" { 
  source  = "jerinrathnam/ecs-cluster/aws"

    cluster_name      = "my-cluster"
    name              = ["service-1"]
    container_images  = ["hello-world"]
    port              = [80]
    security_groups   = ["sg-0123456789abcdef"]
    subnet_ids        = ["subnet-s123f7f546", "subnet-32g745g56"]

    tags = {
      "Env" = "test"
    }
  }
```

### 3. Example code for using existing Cloudwatch log group ECR repo and IAM role
```
  module "ecs" { 
  source  = "jerinrathnam/ecs-cluster/aws"

    cluster_name                = "my-cluster"
    name                        = ["service-1"]
    port                        = [80]
    security_groups             = ["sg-0123456789abcdef"]
    subnet_ids                  = ["subnet-s123f7f546", "subnet-32g745g56"]
    create_cloudwatch_log_group = false
    create_ecr_repository       = false
    ecs_task_role_name          = "task-role-name"
    cloudwatch_log_group_names  = ["log-group-1"]
    ecr_repo_names              = ["ecr-repo-1"]

    tags = {
      "Env" = "test"
    }
  }
```


## Examples

- [Multiple ECS Services](https://github.com/jerinrathnam/terraform-aws-ecs-cluster/tree/master/examples/multiple-ecs-services)
- [Without Auto Scaling](https://github.com/jerinrathnam/terraform-aws-ecs-cluster/tree/master/examples/without-autoscaling)
- [With Load Balancing enabled](https://github.com/jerinrathnam/terraform-aws-ecs-cluster/tree/master/examples/with-load-balancing)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Description

This module will create an ECS Cluster, ECS Services, Task Definitions, App Autoscaling Policies..

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecr_lifecycle_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Whether the public ip for service should be created | `bool` | `true` | no |
| <a name="input_autoscaling_adjustment_type"></a> [autoscaling\_adjustment\_type](#input\_autoscaling\_adjustment\_type) | Whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity. | `string` | `"PercentChangeInCapacity"` | no |
| <a name="input_autoscaling_cooldown"></a> [autoscaling\_cooldown](#input\_autoscaling\_cooldown) | Amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start. | `number` | `120` | no |
| <a name="input_autoscaling_metric_aggregation_type"></a> [autoscaling\_metric\_aggregation\_type](#input\_autoscaling\_metric\_aggregation\_type) | Aggregation type for the policy's metrics. Valid values are 'Minimum', 'Maximum', and 'Average' | `string` | `"Average"` | no |
| <a name="input_autoscaling_min_adjustment_magnitude"></a> [autoscaling\_min\_adjustment\_magnitude](#input\_autoscaling\_min\_adjustment\_magnitude) | Minimum number to adjust your scalable dimension as a result of a scaling activity. | `string` | `null` | no |
| <a name="input_autoscaling_policy_type"></a> [autoscaling\_policy\_type](#input\_autoscaling\_policy\_type) | Policy type. Valid values are StepScaling and TargetTrackingScaling | `string` | `"TargetTrackingScaling"` | no |
| <a name="input_autoscaling_scale_in_cooldown"></a> [autoscaling\_scale\_in\_cooldown](#input\_autoscaling\_scale\_in\_cooldown) | Amount of time, in seconds, after a scale in activity completes before another scale in activity can start. | `number` | `null` | no |
| <a name="input_autoscaling_scale_out_cooldown"></a> [autoscaling\_scale\_out\_cooldown](#input\_autoscaling\_scale\_out\_cooldown) | Amount of time, in seconds, after a scale out activity completes before another scale out activity can start. | `number` | `null` | no |
| <a name="input_autoscaling_step_adjustment"></a> [autoscaling\_step\_adjustment](#input\_autoscaling\_step\_adjustment) | Set of adjustments that manage scaling. | <pre>list(<br>    object(<br>      {<br>        lower_bound        = number<br>        upper_bound        = number<br>        scaling_adjustment = number<br>      }<br>    )<br>  )</pre> | `null` | no |
| <a name="input_cloudwatch_log_group_names"></a> [cloudwatch\_log\_group\_names](#input\_cloudwatch\_log\_group\_names) | List of cloudwatch log group names. Only need if 'create\_cloudwatch\_log\_group' is set to 'false' | `list(string)` | `null` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name for the Cluster | `string` | n/a | yes |
| <a name="input_container_cpu"></a> [container\_cpu](#input\_container\_cpu) | List of CPU for container definition. If a single value is same for all containers, then provide one value is enough | `list(number)` | <pre>[]</pre> | no |
| <a name="input_container_log_driver"></a> [container\_log\_driver](#input\_container\_log\_driver) | The log driver to use for the container. | `string` | `"awslogs"` | no |
| <a name="input_container_images"></a> [container\_images](#input\_container\_images) | List of images for task definition. | `list(string)` | `[]` | no |
| <a name="input_container_memory"></a> [container\_memory](#input\_container\_memory) | List of Memory for container definition. If a single value is same for all containers, then provide one value is enough | `list(number)` | <pre>[]</pre> | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | List of the names for containers | `list(string)` | `null` | no |
| <a name="input_cpu_architecture"></a> [cpu\_architecture](#input\_cpu\_architecture) | CPU architecture for Task definition | `string` | `"X86_64"` | no |
| <a name="input_cpu_utilization_target_value"></a> [cpu\_utilization\_target\_value](#input\_cpu\_utilization\_target\_value) | List of avarage CPU utilization target values in percentage for services. If a single value is same for all services, then provide one value is enough | `list(number)` | <pre>[<br>  75<br>]</pre> | no |
| <a name="input_create_cloudwatch_log_group"></a> [create\_cloudwatch\_log\_group](#input\_create\_cloudwatch\_log\_group) | Whether cloudwatch log group needs to be create or not | `bool` | `true` | no |
| <a name="input_create_cluster"></a> [create\_cluster](#input\_create\_cluster) | Whether ecs cluster needs to be create or not | `bool` | `true` | no |
| <a name="input_create_ecr_repository"></a> [create\_ecr\_repository](#input\_create\_ecr\_repository) | Whether ecr repository needs to be create or not | `bool` | `true` | no |
| <a name="input_cw_logs_retention_in_days"></a> [cw\_logs\_retention\_in\_days](#input\_cw\_logs\_retention\_in\_days) | Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653, and 0 | `number` | `30` | no |
| <a name="input_deployment_controller"></a> [deployment\_controller](#input\_deployment\_controller) | Type of deployment in ecs | `string` | `"ECS"` | no |
| <a name="input_ecr_repo_names"></a> [ecr\_repo\_names](#input\_ecr\_repo\_names) | List of the names of ecr repositories. Only needed if 'create\_ecr\_repository' is set to 'false' | `list(string)` | `null` | no |
| <a name="input_ecs_task_role_name"></a> [ecs\_task\_role\_name](#input\_ecs\_task\_role\_name) | Name of ecs task iam role | `string` | `null` | no |
| <a name="input_enable_autoscaling"></a> [enable\_autoscaling](#input\_enable\_autoscaling) | Whether to enable Autoscaling for ECS Services | `bool` | `true` | no |
| <a name="input_enable_ecr_lifecycle"></a> [enable\_ecr\_lifecycle](#input\_enable\_ecr\_lifecycle) | Whether to enable ECR Life Cycle Policy | `bool` | `true` | no |
| <a name="host_port"></a> [host\_port](#input\_host\_port\_) | List of host ports | `list(string)` | `[]` | no |
| <a name="input_image_tags"></a> [image\_tags](#input\_image\_tags) | List of ECR image tags. If tags are 'latest' for all the images just leave it default. If a single value is same for all services, then provide one value is enough | `list(string)` | <pre>[<br>  "latest"<br>]</pre> | no |
| <a name="input_load_balancing"></a> [load\_balancing](#input\_load\_balancing) | Whether to attach loadbalancer with ecs services | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | List of names for services | `list(string)` | n/a | yes |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | Network mode for ecs task definition | `string` | `"awsvpc"` | no |
| <a name="input_operating_system_family"></a> [operating\_system\_family](#input\_operating\_system\_family) | Name of an operating system for task definition | `string` | `"LINUX"` | no |
| <a name="input_port"></a> [port](#input\_port) | List of the ports for containers. If a single value is same for all services, then provide one value is enough | `list(number)` | <pre>[<br>  80<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | Region for infrastructure | `string` | `null` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | List of IDs of security groups. If a single value is same for all services, then provide one value is enough | `list(string)` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of the Ids of subnets | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for your infrastructure | `map(string)` | `{}` | no |
| <a name="input_target_group_arns"></a> [target\_group\_arns](#input\_target\_group\_arns) | List of ARNs of target groups. This is need if target groups are created from another module | `list(string)` | `null` | no |
| <a name="input_target_group_names"></a> [target\_group\_names](#input\_target\_group\_names) | List of Names of target groups. This is need if target groups are created via console | `list(string)` | `null` | no |
| <a name="input_task_commands"></a> [task\_commands](#input\_task\_commands) | List of The commands that's passed to the container. | `list(string)` | `null` | no |
| <a name="input_task_cpu"></a> [task\_cpu](#input\_task\_cpu) | List of CPU for task definition. If a single value is same for all services, then provide one value is enough | `list(number)` | <pre>[<br>  256<br>]</pre> | no |
| <a name="input_task_desired_count"></a> [task\_desired\_count](#input\_task\_desired\_count) | List of Desired count for task running in service. If a single value is same for all services, then provide one value is enough | `list(number)` | <pre>[<br>  1<br>]</pre> | no |
| <a name="input_task_entry_points"></a> [task\_entry\_points](#input\_task\_entry\_points) | List of The entry points that's passed to the container | `list(string)` | `null` | no |
| <a name="input_task_env_files"></a> [task\_env\_files](#input\_task\_env\_files) | A list of files containing the environment variables to pass to a container. | `list(map(string))` | `null` | no |
| <a name="input_task_env_vars"></a> [task\_env\_vars](#input\_task\_env\_vars) | List of key-value pair of environment variables for ecs task definition | `list(map(string))` | `null` | no |
| <a name="input_task_health_check"></a> [task\_health\_check](#input\_task\_health\_check) | The container health check command and associated configuration parameters for the container. | `map(any)` | `null` | no |
| <a name="input_task_host_name"></a> [task\_host\_name](#input\_task\_host\_name) | The hostname to use for your container. | `string` | `null` | no |
| <a name="input_task_launch_type"></a> [task\_launch\_type](#input\_task\_launch\_type) | Launch type for service and task | `string` | `"FARGATE"` | no |
| <a name="input_task_max_capacity"></a> [task\_max\_capacity](#input\_task\_max\_capacity) | List of maximum capacity number for task. If a single value is same for all services, then provide one value is enough | `list(number)` | <pre>[<br>  5<br>]</pre> | no |
| <a name="input_task_memory"></a> [task\_memory](#input\_task\_memory) | List of Memory for task definition. If a single value is same for all services, then provide one value is enough | `list(number)` | <pre>[<br>  512<br>]</pre> | no |
| <a name="input_task_min_capacity"></a> [task\_min\_capacity](#input\_task\_min\_capacity) | List of minimum capacity number for task. If a single value is same for all services, then provide one value is enough | `list(number)` | <pre>[<br>  1<br>]</pre> | no |
| <a name="input_task_mount_point"></a> [task\_mount\_point](#input\_task\_mount\_point) | The mount points for data volumes in your container. | `list(map(any))` | `null` | no |
| <a name="input_task_volume"></a> [task\_volume](#input\_task\_volumes\_from) | Data volumes to mount from efs or docker or windows | `list` | `null` | no |
| <a name="input_task_volumes_from"></a> [task\_volumes\_from](#input\_task\_volumes\_from) | Data volumes to mount from another container | `list(map(any))` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_log_groups"></a> [cloudwatch\_log\_groups](#output\_cloudwatch\_log\_groups) | Full details about Cloudwatch Log Groups |
| <a name="output_ecr_repositories"></a> [ecr\_repositories](#output\_ecr\_repositories) | Full details about ECR Repositories |
| <a name="output_ecr_repository_arns"></a> [ecr\_repository\_arns](#output\_ecr\_repository\_arns) | List of ARNs of ECR Repositories |
| <a name="output_ecs_service"></a> [ecs\_service](#output\_ecs\_service) | Full details about ECS Services |
| <a name="output_ecs_task_definition"></a> [ecs\_task\_definition](#output\_ecs\_task\_definition) | Full details about ECS Task Definitions |
| <a name="output_ecs_task_definition_arn"></a> [ecs\_task\_definition\_arn](#output\_ecs\_task\_definition\_arn) | List of ARNs of ECS Task Definitions |


## Authors
Module is maintained by [Jerin Rathnam](https://github.com/jerinrathnam).

**LinkedIn:** _[Jerin Rathnam](https://www.linkedin.com/in/jerin-rathnam)_.

## License
Apache 2 Licensed. See [LICENSE](https://github.com/jerinrathnam/terraform-aws-ecs-cluster/blob/master/LICENSE) for full details.