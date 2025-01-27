output "user_pool_id" {
  value = aws_cognito_user_pool.example.id
}

output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.example_client.id
}

output "lambda_function_url" {
  value = aws_lambda_function_url.example_lambda_url.function_url
}