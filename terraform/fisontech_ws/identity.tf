# resource "aws_directory_service_directory" "aws-managed-ad" {
#   name = "kopicloud.local"
#   description = "KopiCloud Managed Directory Service"
#   password = "Sup3rS3cr3tP@ssw0rd"
#   edition = "Standard"
#   type = "MicrosoftAD"
#   vpc_settings {
#     vpc_id = module.vpc.vpc_id
#     subnet_ids = module.vpc.private_subnets
#   }
#   tags = {
#     Name = "kopicloud-managed-ad"
#     Environment = "Development"
#   }
# }

# data "aws_iam_policy_document" "workspaces" {
#   statement {
#     actions = ["sts:AssumeRole"]
#     principals {
#       type = "Service"
#       identifiers = ["workspaces.amazonaws.com"]
#     }
#   }
# }
# resource "aws_iam_role" "workspaces-default" {
#   name = "workspaces_DefaultRole"
#   assume_role_policy = data.aws_iam_policy_document.workspaces.json
# }
# resource "aws_iam_role_policy_attachment" "workspaces-default-service-access" {
#   role = aws_iam_role.workspaces-default.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonWorkSpacesServiceAccess"
# }
# resource "aws_iam_role_policy_attachment" "workspaces-default-self-service-access" {
#   role = aws_iam_role.workspaces-default.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonWorkSpacesSelfServiceAccess"
# }
