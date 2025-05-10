resource "aws_iam_role" "firehose_role" {
  name = "firehose_delivery_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "firehose.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "firehose_policy" {
  name = "firehose_delivery_policy"
  role = aws_iam_role.firehose_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetBucketLocation",
          "s3:ListBucket"
        ],
        Resource = [
          "${var.s3_bucket_arn}",
          "${var.s3_bucket_arn}/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "kinesis:Get*",
          "kinesis:DescribeStream",
          "kinesis:List*",
          "kinesis:SubscribeToShard"
        ],
        Resource = var.kinesis_stream_arn
      },
      {
        Effect = "Allow",
        Action = [
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_kinesis_firehose_delivery_stream" "this" {
  name        = var.firehose_name
  destination = "extended_s3"

  kinesis_source_configuration {
    kinesis_stream_arn = var.kinesis_stream_arn
    role_arn           = aws_iam_role.firehose_role.arn
  }

  extended_s3_configuration  {
    role_arn           = aws_iam_role.firehose_role.arn
    bucket_arn         = var.s3_bucket_arn
    buffering_interval = 60
    compression_format = "UNCOMPRESSED"
  }
}
