module "ecs-cluster" {
  source = "../../"

  cluster_name = "my-cluster"
  name         = ["service-1", "service-2", "service-3"]
  port         = [80] #container port
  # port = [80, 3000, 4000] # this is for multiple container ports
  host_port       = [8080, 8081, 8082] # if container port and host ports are same 
  region          = "us-east-2"
  security_groups = ["sg-0123456789abcdef"]
  subnet_ids      = ["subnet-s123f7f546", "subnet-32g745g56"]

  tags = {
    "Env" = "test"
  }
}