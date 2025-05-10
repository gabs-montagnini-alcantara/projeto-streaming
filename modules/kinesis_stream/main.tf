resource "aws_kinesis_stream" "kinesis_stream_projeto" {
  name             = var.stream_name
  shard_count      = var.shard_count
  retention_period = var.retention_hours
}