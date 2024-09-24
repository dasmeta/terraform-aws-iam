# Assume role policy document with dynamic statements
data "aws_iam_policy_document" "assume_role_policy" {
  dynamic "statement" {
    for_each = var.trust_relationship

    content {
      effect  = lookup(statement.value, "effect", "Allow")
      actions = statement.value.actions

      principals {
        type        = statement.value.principals.type
        identifiers = statement.value.principals.identifiers
      }

      dynamic "condition" {
        for_each = length(statement.value.conditions) > 0 ? statement.value.conditions : []

        content {
          test     = condition.value.type  # Condition type (e.g., StringEquals)
          variable = condition.value.key   # Condition variable (e.g., "SAML:aud")
          values   = condition.value.value # Condition values (list of strings)
        }
      }
    }
  }
}

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
  name        = var.name
  description = var.description

  policy = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_role" "aws-role" {
  name = var.name

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "awsrole" {
  policy_arn = aws_iam_policy.this.arn
  role       = aws_iam_role.aws-role.name
}
