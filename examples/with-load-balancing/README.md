## Requirements

No requirements.

## Providers

No providers.

## Description

This is an example for create an ECS Cluster with load balancing enabled.

## Example

```
  module "ecs-cluster" {
    source = "../../"

    cluster_name       = "my-cluster"
    name               = ["service-1"]
    port               = [80]
    region             = "us-east-2"
    security_groups    = ["sg-0123456789abcdef"]
    subnet_ids         = ["subnet-s123f7f546", "subnet-32g745g56"]
    load_balancing     = true
    target_group_names = ["target-group-name-1"]

    tags = {
      "Env" = "test"
    }
  }
```

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecs-cluster"></a> [ecs-cluster](#module\_ecs-cluster) | ../../ | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
