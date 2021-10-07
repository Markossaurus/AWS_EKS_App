resource "aws_eks_cluster" "haproxy" {
  name     = "haproxy"
  role_arn = aws_iam_role.eks-cluster.arn

  vpc_config {
    subnet_ids = module.vpc.public_subnets
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.haproxy.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.haproxy.certificate_authority[0].data
}


resource "aws_eks_node_group" "haprox" {
  cluster_name    = aws_eks_cluster.haproxy.name
  node_group_name = "haprox"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = module.vpc.public_subnets
  instance_types  = ["t3.micro"]
  
  remote_access {
      ec2_ssh_key = "terraform-sshkey-pc"
  }

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }


  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

