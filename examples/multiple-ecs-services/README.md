## Requirements

No requirements.

## Providers

No providers.

## Description

This is an example for create an ECS Cluster with multiple ECS Services with same or different ports.

## Example

```
  module "ecs-cluster" {
    source = "../../"

    cluster_name = "my-cluster"
    name         = ["service-1", "service-2", "service-3"]
    # port       = [8080] # If container port same for all services
    port            = [8080, 3000, 4000] # If Ports are different for all services
    host_port       = [8080, 8081, 8082] # Need only If container port and host ports are not same. If both are same This can be command out
    region          = "us-east-2"
    security_groups = ["sg-0123456789abcdef"]
    subnet_ids      = ["subnet-s123f7f546", "subnet-32g745g56"]

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
