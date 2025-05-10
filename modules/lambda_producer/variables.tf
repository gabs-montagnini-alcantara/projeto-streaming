variable "kinesis_stream" {
  description = "Nome do stream do Kinesis"
  type        = string
}

variable "kinesis_stream_arn" {
  description = "ARN do Kinesis Stream"
  type        = string
}

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
