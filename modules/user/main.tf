
# Dynamically create the IAM policy document
data "aws_iam_policy_document" "policy" {
  dynamic "statement" {
    for_each = var.policy
    content {
      actions   = statement.value.actions
      resources = statement.value.resources
    }
  }
}

resource "aws_iam_policy" "this" {
  name        = "${var.name}-UserPoilcy"
  description = var.description

  policy = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_user" "aws-user" {
  name = var.name

}

resource "aws_iam_user_policy_attachment" "awsrole" {
  policy_arn = aws_iam_policy.this.arn
  user       = aws_iam_user.aws-user.name
}
