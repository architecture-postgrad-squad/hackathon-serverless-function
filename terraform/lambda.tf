resource "aws_lambda_layer_version" "python_dependencies" {
  layer_name  = "python-dependencies"
  filename    = "../function/lambda-dependencies.zip"
  compatible_runtimes = ["python3.11"]
}

resource "aws_lambda_function" "lambda_function" {
  function_name = "lambda-auth"
  role          = "arn:aws:iam::645944551140:role/LabRole"
  handler       = "app.lambda_handler"
  runtime       = "python3.11"
  filename      = "../function/function.zip" 
  source_code_hash = filebase64sha256("../function/function.zip" )

  layers = [
    aws_lambda_layer_version.python_dependencies.arn
  ]
}

resource "aws_lambda_function_url" "example_lambda_url" {
  function_name = aws_lambda_function.lambda_function.function_name
  authorization_type = "NONE" 
}
