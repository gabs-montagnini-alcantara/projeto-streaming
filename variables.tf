# S3
variable "region" {
  description = "AWS region para os recursos"
  type        = string
  default     = "us-east-1"
}
variable "bucket_name" {
  description = "Nome do bucket S3 destino"
  type        = string
}
##############################################################
# Lambda
variable "lambda_name" {
  description = "Nome da funcao lambda producer"
  type        = string
}
variable "memory_size" {
  description = "Memória da Lambda em MB"
  type        = number
}
variable "timeout" {
  description = "Tempo máximo de execução da Lambda em segundos"
  type        = number
}
##############################################################
# KDS
variable "kds_name" {
  description = "Nome do Kinesis Data Stream"
  type        = string
}
variable "shard_count" {
  description = "Número de shards para o stream"
  type        = number
  default     = 1
}
variable "retention_hours" {
  description = "Tempo de retenção dos dados no stream (em horas)"
  type        = number
}
##############################################################
# KDF
variable "kdf_name" {
  description = "Nome do Kinesis Firehose"
  type        = string
}

##############################################################
# KDA
variable "kda_name" {
  description = "Nome do Kinesis Firehose"
  type        = string
}

##############################################################
# Glue catalog
variable "glue_database_name" {
  description = "Glue catalog database name"
  type        = string
}
variable "glue_table_name" {
  description = "Glue catalog table name"
  type        = string
}
variable "glue_s3_output_path" {
  description = "S3 output path for Glue and Firehose"
  type        = string
}
