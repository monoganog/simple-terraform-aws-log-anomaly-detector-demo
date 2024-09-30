terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.69"
    }
    awscc = {
      source  = "hashicorp/awscc"
      version = "~> 1.16.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "awscc" {
  region = var.aws_region
}

resource "aws_cloudwatch_log_group" "my-log-group" {
  name = "log-group-example"
  tags = {
    Environment = "dev"
  }
}

resource "awscc_logs_log_anomaly_detector" "my-anomaly-detector" {
  log_group_arn_list    = [aws_cloudwatch_log_group.my-log-group.arn]
  detector_name         = "example-detector"
  evaluation_frequency  = "FIVE_MIN"
}