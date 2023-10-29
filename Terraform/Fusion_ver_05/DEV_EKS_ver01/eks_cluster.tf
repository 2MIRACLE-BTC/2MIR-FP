#################### /eks_cluster.tf
#################### for DEV_EKS
resource "aws_eks_cluster" "DEV_eks" {
  name     = "DEV_eks"
  version  = "1.27"
  role_arn = aws_iam_role.DEV_EKS_role.arn
  vpc_config {
    subnet_ids = [data.terraform_remote_state.get_infra.outputs.worker_A_PRInet[1], data.terraform_remote_state.get_infra.outputs.worker_C_PRInet[1]]
  }
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    aws_iam_role_policy_attachment.AmazonEBSCSIDriverPolicy,
  ]
}

resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.DEV_eks.name
  addon_name   = "coredns"
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name = aws_eks_cluster.DEV_eks.name
  addon_name   = "kube-proxy"
}

resource "aws_eks_addon" "vpc-cni" {
  cluster_name = aws_eks_cluster.DEV_eks.name
  addon_name   = "vpc-cni"
}

resource "aws_eks_addon" "efs-csi" {
  cluster_name = aws_eks_cluster.DEV_eks.name
  addon_name   = "aws-efs-csi-driver"
}