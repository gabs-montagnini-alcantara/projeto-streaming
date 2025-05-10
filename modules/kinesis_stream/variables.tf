variable "stream_name" {
  description = "Nome do Kinesis Data Stream"
  type        = string
}

variable "shard_count" {
  description = "Número de shards para o stream"
  type        = number
}

variable "retention_hours" {
  description = "Tempo de retenção dos dados no stream (em horas)"
  type        = number
  default     = 24
}
