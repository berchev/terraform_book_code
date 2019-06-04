########################### FIRST PART OF THE CODE !!!! ######################
# We will create bucket in order to have shared storage for state files
# Please comment SECOND PART OF THE CODE before run this.
# Once bucket is created you can uncomment SECOND part OF THE CODE and run the whole thing

variable "bucket_name" {
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

########################### SECOND PART OF THE CODE !!!! ######################
# In order to avoid local store of the bucket's state file, we will use "backend - S3"
# In this way terraform will store the state file in your bucket
# Note that "backend - S3" do not support interpolation. Name of the bucket need to be hardcoded

terraform {
  backend "s3" {
    bucket  = "berchev-terraform-book-state"
    region  = "us-east-1"
    key     = "global/s3/terraform.tfstate"
    encrypt = true
  }
}
