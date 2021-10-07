terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"

    kubernetes = {
        source = "hashicorp/kubernetes"
        version = "2.5.0"
        }

    helm = {
        source = "hashicorp/helm"
        version = "2.3.0"
        }
    }
  }
}


provider "aws"{
    profile = "default"
    region = "eu-central-1"
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET
}

provider "kubernetes" {
  host                   = aws_eks_cluster.haproxy.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.haproxy.certificate_authority[0].data)
  token                  = aws_eks_cluster_auth.haproxy.token
}

provider "helm" {
    kubernetes {
      host                   = aws_eks_cluster.haproxy.endpoint
      cluster_ca_certificate = base64decode(aws_eks_cluster.haproxy.certificate_authority[0].data)
      token                  = aws_eks_cluster_auth.haproxy.token
       }
    }



data "aws_availability_zones" "available" {
  state = "available"
}