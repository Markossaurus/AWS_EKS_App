terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
  
}

provider "aws"{
    profile = "default"
    region = "eu-central-1"
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET
}

data "aws_availability_zones" "available" {
  state = "available"
}


data "aws_regions" "current" {

  filter {
    name   = "region-name"
    values = ["eu-central-1", "eu-west-1", "eu-west-2"]
  }
}