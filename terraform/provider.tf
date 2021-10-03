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