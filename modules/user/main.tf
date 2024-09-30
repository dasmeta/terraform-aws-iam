

###
module "iam_user" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-user"
  version                       = "5.44.1"
  name                          = var.username
  create_user                   = var.create_user
  create_iam_user_login_profile = var.console
  create_iam_access_key         = var.api
  pgp_key                       = var.pgp_key
}

resource "aws_iam_user_policy_attachment" "user-attach" {
  for_each   = toset(var.policy_attachment)
  user       = var.username
  policy_arn = each.value
  depends_on = [
    module.iam_user
  ]
}

data "aws_iam_policy_document" "policy" {
  dynamic "statement" {
    for_each = var.policy
    content {
      actions   = statement.value.actions
      resources = statement.value.resources
    }
  }
}

resource "aws_iam_user_policy" "iam_user_policy" {
  count      = var.create_policy && var.create_user ? 1 : 0
  name       = "policy-${var.username}"
  user       = var.username
  depends_on = [module.iam_user]
  policy     = data.aws_iam_policy_document.policy.json
}
