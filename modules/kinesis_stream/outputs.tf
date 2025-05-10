output "stream_name" {
  value = aws_kinesis_stream.kinesis_stream_projeto.name
}

output "stream_arn" {
  value = aws_kinesis_stream.kinesis_stream_projeto.arn
}