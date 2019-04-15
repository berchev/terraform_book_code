provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "../../../../modules/services/webserver-cluster"

  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "berchev-terraform-book-state"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"
  server_port            = 8080

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 10
  enable_autoscaling = true
}
