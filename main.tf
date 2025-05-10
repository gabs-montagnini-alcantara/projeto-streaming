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
  stream_name    = var.kds_name
  shard_count    = 1
  retention_hours = var.retention_hours
}

module "lambda_producer" {
  source          = "./modules/lambda_producer"
  kinesis_stream  = module.kinesis_stream.stream_name
  kinesis_stream_arn  = module.kinesis_stream.stream_arn
  lambda_name     = var.lambda_name
  memory_size     = var.memory_size
  timeout         = var.timeout
}

module "firehose_delivery" {
  source               = "./modules/firehose_delivery"
  firehose_name        = var.kdf_name
  kinesis_stream_arn   = module.kinesis_stream.stream_arn
  s3_bucket_arn        = module.s3.bucket_arn
  glue_database_name   = module.glue_catalog.database_name
  glue_table_name      = module.glue_catalog.table_name
}

module "glue_catalog" {
  source            = "./modules/glue_catalog"
  database_name     = var.glue_database_name
  table_name        = var.glue_table_name
  s3_output_path    = module.s3.bucket_name
}
