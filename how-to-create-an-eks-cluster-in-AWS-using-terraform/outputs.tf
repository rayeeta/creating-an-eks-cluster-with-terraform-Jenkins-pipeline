############################
# Outputs
############################
output "eks_cluster_endpoint" {
  description = "EKS Cluster endpoint for kubeconfig"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_certificate_authority" {
  description = "Certificate authority data for kubeconfig"
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "eks_cluster_arn" {
  description = "ARN of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.arn
}

output "eks_node_group_arn" {
  description = "ARN of the EKS Node Group"
  value       = aws_eks_node_group.node_group.arn
}

output "eks_node_group_instance_types" {
  description = "EC2 instance types used in the node group"
  value       = aws_eks_node_group.node_group.instance_types
}

output "eks_node_group_subnets" {
  description = "Subnet IDs for the EKS Node Group"
  value       = aws_eks_node_group.node_group.subnet_ids
}
