output "arn" {
  value       = aws_iam_role.aws-role.arn
  description = "Created role arn"
}

output "id" {
  value       = aws_iam_role.aws-role.id
  description = "Created role id"
}

output "assume_role_policy" {
  value       = aws_iam_role.aws-role.assume_role_policy
  description = "Policy document associated with the role"
}
