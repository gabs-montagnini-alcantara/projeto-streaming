resource "aws_iam_role" "lambda_role" {
  name = "lambda-kinesis-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy_attachment" "lambda_basic_execution" {
  name       = "attach-lambda-basic"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "lambda_kinesis_policy" {
  name = "lambda-kinesis-putrecord"
  role = aws_iam_role.lambda_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "kinesis:PutRecord"
        ],
        Resource = var.kinesis_stream_arn
      }
    ]
  })
}


resource "aws_lambda_function" "producer" {
  function_name = var.lambda_name
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.9"
  handler       = "index.lambda_handler"
  memory_size   = var.memory_size
  timeout       = var.timeout
  filename         = "${path.module}/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")

  environment {
    variables = {
      KINESIS_STREAM = var.kinesis_stream
    }
  }
}

output "lambda_function_name" {
  value = aws_lambda_function.producer.function_name
}
