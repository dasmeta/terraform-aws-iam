resource "aws_iam_policy" "this" {
  name        = var.name
  description = var.description

  policy = var.policy
}

resource "aws_iam_role" "aws-role" {
  name = var.name

  assume_role_policy = var.trust-relationship
}

resource "aws_iam_role_policy_attachment" "AWSRole" {
  policy_arn = aws_iam_policy.this.arn
  role       = aws_iam_role.aws-role.name
}
