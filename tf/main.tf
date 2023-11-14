terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.25.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.4.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

data "aws_iam_role" "iam_for_lambda" {
  name = "main-role-vvl4oass"
}

data "archive_file" "init" {
  type        = "zip"
  source_dir  = "../main"
  output_path = "${path.module}/main.zip"
}


resource "aws_lambda_function" "time" {
  function_name    = "main"
  filename         = data.archive_file.init.output_path
  handler          = "main"
  source_code_hash = data.archive_file.init.output_base64sha256
  role             = data.aws_iam_role.iam_for_lambda.arn
  runtime          = "go1.x"
  memory_size      = 128
  timeout          = 10
}
