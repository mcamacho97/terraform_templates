data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda_azure" {
  name               = var.iam_for_lambda_azure
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role" "iam_for_lambda_rotate" {
  name               = var.iam_for_lambda_rotate
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}