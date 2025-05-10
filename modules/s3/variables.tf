variable "region" {
  description = "AWS region para os recursos"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Nome do bucket S3 destino"
  type        = string
}
