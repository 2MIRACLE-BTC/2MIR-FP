# resource "aws_iam_role" "ebs_csi_irsa_role" {
#   name = "AmazonEKS_EBS_CSI_DriverRole"

#   assume_role_policy = <<POLICY
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Principal": {
#                 "Service": "eks.amazonaws.com"
#             },
#             "Action": "sts:AssumeRole"
#         }
#     ]
# }
# POLICY
# }

# # EBS CSI policy attachment (assuming the policy ARN is known)
# resource "aws_iam_role_policy_attachment" "ebs_csi_irsa_policy_attachment" {
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy" # This might need to be updated based on the exact policy ARN.
#   role       = aws_iam_role.ebs_csi_irsa_role.name
# }
