terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
    kubernetes = {
        source = "hashicorp/kubernetes"
        version = "2.5.0"
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

data "aws_eks_cluster_auth" "haproxy" {
  name = var.cluster_name
    depends_on = [
    aws_eks_cluster.haproxy,
    aws_eks_node_group.haprox,
  ]
}


provider "kubernetes" {
  host                   = aws_eks_cluster.haproxy.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.haproxy.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.haproxy.token

    depends_on = [
    aws_eks_cluster.haproxy,
    aws_eks_node_group.haprox,
  ]
}
