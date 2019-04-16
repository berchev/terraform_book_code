provider "aws" {
  region = "us-east-1"
}

module "mysql" {
  source = "../../../../modules/data-stores/mysql"

  db_password       = "my_password"
  db_username       = "admin"
  db_name           = "example_database"
  instance_class    = "db.t2.micro"
  allocated_storage = 10
}

terraform {
  backend "s3" {
    bucket  = "berchev-terraform-book-state"
    region  = "us-east-1"
    key     = "stage/data-stores/mysql/terraform.tfstate"
    encrypt = true
  }
}
