variable "firehose_name" {
  description = "Nome do Kinesis Firehose"
  type        = string
}

variable "kinesis_stream_arn" {
  description = "ARN do stream do Kinesis"
  type        = string
}

variable "s3_bucket_arn" {
  description = "ARN do bucket S3 destino"
  type        = string
}
