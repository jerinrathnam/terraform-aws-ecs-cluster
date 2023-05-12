module "ecs-cluster" {
  source = "../../"

  cluster_name         = "my-cluster"
  name                 = ["service-1"]
  port                 = [80]
  region               = "us-east-2"
  enable_autoscaling   = false
  enable_ecr_lifecycle = false
  security_groups      = ["sg-0123456789abcdef"]
  subnet_ids           = ["subnet-s123f7f546", "subnet-32g745g56"]

  tags = {
    "Env" = "test"
  }
}