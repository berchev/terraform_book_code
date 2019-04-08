amazon_ami = "ami-40d28157"

terragrunt = {
  remote_state {
    backend = "s3"
    config {
      bucket  = "berchev-terraform-book-state"
      key     = "example_locking/terraform.tfstate"
      region  = "us-east-1"
      encrypt = true
      dynamodb_table = "my-lock-table"
    }
  }
}