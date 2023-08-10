
module "iam_for_lambda" {
  source                = "./modules/security"
  iam_for_lambda_azure  = var.iam_for_lambda_azure
  iam_for_lambda_rotate = var.iam_for_lambda_rotate
}

data "archive_file" "LambdaForUpdateServiceEndpointAzureDevOps" {
  type        = "zip"
  output_path = var.azuredevops_output_path
  source_dir  = var.azuredevops_source_dir
}

data "archive_file" "LambdaForRotateSecrets" {
  type        = "zip"
  output_path = var.rotatesecrets_output_path
  source_dir  = var.rotatesecrets_source_dir
}

resource "aws_lambda_function" "LambdaForUpdateServiceEndpointAzureDevOps" {
  function_name    = "${var.env_prefix}-LambdaForUpdateServiceEndpointAzureDevOps"
  role             = module.iam_for_lambda.iam_for_lambda_azure.arn
  filename         = var.azuredevops_output_path
  handler          = "main/app.lambda_handler"
  source_code_hash = data.archive_file.LambdaForUpdateServiceEndpointAzureDevOps.output_base64sha256
  runtime          = "python3.9"
}

resource "aws_lambda_function" "LambdaForRotateSecrets" {
  function_name    = "${var.env_prefix}-LambdaForRotateSecrets"
  role             = module.iam_for_lambda.iam_for_lambda_rotate.arn
  filename         = var.rotatesecrets_output_path
  handler          = "main/app.lambda_handler"
  source_code_hash = data.archive_file.LambdaForRotateSecrets.output_base64sha256
  runtime          = "python3.9"
}

resource "aws_secretsmanager_secret" "service_endpoints_secrets" {
  for_each = toset(["secret1", "secret2", "secret3"])
  name     = "demorotate-${each.key}"
}

resource "aws_secretsmanager_secret_rotation" "service_endpoints_secrets_rotation" {
  for_each            = aws_secretsmanager_secret.service_endpoints_secrets
  secret_id           = each.value.id
  rotation_lambda_arn = aws_lambda_function.LambdaForRotateSecrets.arn

  rotation_rules {
    automatically_after_days = 90
  }
}

# resource "aws_sns_topic" "name" {

# }

