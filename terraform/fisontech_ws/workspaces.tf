# resource "aws_workspaces_directory" "workspaces-directory" {
#   directory_id = aws_directory_service_directory.aws-managed-ad.id
#   subnet_ids   = module.vpc.private_subnets
#   depends_on = [aws_iam_role.workspaces-default]
# }

# # Windows Standard Bundle powered by Windows Server 2019
# data "aws_workspaces_bundle" "standard_windows" {
#   bundle_id = "wsb-gk1wpk43z"
# }
# # Linux Standard Bundle powered by Amazon Linux 2
# data "aws_workspaces_bundle" "standard_linux" {
#   bundle_id = "wsb-clj85qzj1"
# }

# resource "aws_kms_key" "workspaces-kms" {
#   description = "KopiCloud KMS"
#   deletion_window_in_days = 7
# }