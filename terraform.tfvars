# Variaveis do S3
region = "us-east-1"
bucket_name = "300821235250-streaming-camada-sor"

# Variaveis do KDS
kds_name = "kinesis-data-streams-projeto-27abd"
shard_count = 1
retention_hours = 24 # Minimo eh 24

# Variaveis do KDF (firehose)
kdf_name = "kinesis-data-firehose-projeto-27abd"

# Variaveis do KDA (flink)
kda_name = "kinesis-data-analytics-projeto-27abd"

# Variaveis da Lambda
lambda_name     = "lambda-producer-projeto-27abd"
memory_size     = 512
timeout         = 60

# Variaveis do Glue Catalog
glue_database_name = "sor_database"
glue_table_name    = "sor_table"
glue_s3_output_path = "s3://meu-bucket-glue/output/"
