############################
# EKS Cluster
############################
resource "aws_eks_cluster" "eks_cluster" {
  name     = "bmt-demo-cluster-1"
  role_arn = aws_iam_role.cluster_role.arn
  version  = "1.33"

  vpc_config {
    subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_policy,
    aws_iam_role_policy_attachment.vpc_policy
  ]
}

############################
# EKS Node Group in Private Subnets
############################
resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "my-node-group2"
  node_role_arn   = aws_iam_role.node_group_role.arn
  subnet_ids      = [aws_subnet.private1.id, aws_subnet.private2.id]

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }

  ami_type       = "AL2023_ARM_64_STANDARD"
  instance_types = ["t4g.large"]
  capacity_type  = "ON_DEMAND"
  disk_size      = 20

  # Tag only the EC2 worker nodes
  tags = {
    Environment = "bmt-test-env"
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_group_policy,
    aws_iam_role_policy_attachment.node_group_cni_policy,
    aws_iam_role_policy_attachment.node_group_registry_policy
  ]
}

