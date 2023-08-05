
module "iam_for_lambda" {
  source        = "./modules/security"
  iam_role_name = var.iam_role_name
}

data "archive_file" "lambda" {
  type        = "zip"
  # source_file = "./DEV-ADServiceEndpoint/main/app.py"
  output_path = "DEV-ADServiceEndpoint.zip"
  source_dir = "./DEV-ADServiceEndpoint/"
}

resource "aws_lambda_function" "ServiceEndpointUpdate" {
  function_name    = "${var.env_prefix}-ServiceEndpointUpdate"
  role             = module.iam_for_lambda.iam_role.arn
  filename         = "DEV-ADServiceEndpoint.zip"
  handler          = "main/app.lambda_handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime          = "python3.9"
}

# resource "aws_lambda_function" "RotateSecrets" {
#   function_name = "${var.env_prefix}-RotateSecrets"
# }

# resource "aws_secretsmanager_secret" "service_endpoint_secrets" {

# }

# resource "aws_sns_topic" "name" {

# }

