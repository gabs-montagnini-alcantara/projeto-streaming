terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.region
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
}

module "kinesis_stream" {
  source         = "./modules/kinesis_stream"
  stream_name    = var.kdf_name
  shard_count    = 1
  retention_hours = var.retention_hours
}

module "lambda_producer" {
  source          = "./modules/lambda_producer"
  kinesis_stream  = module.kinesis_stream.stream_name
  lambda_name     = var.lambda_name
  memory_size     = var.memory_size
  timeout         = var.timeout
}

module "firehose_delivery" {
  source               = "./modules/firehose_delivery"
  firehose_name        = var.kdf_name
  kinesis_stream_arn   = module.kinesis_stream.stream_arn
  s3_bucket_arn        = module.s3.bucket_arn
}
