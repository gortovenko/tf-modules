resource "aws_cloudwatch_event_rule" "lambda_schedule" {
  name                = "TriggerLambdaEvery5Minutes"
  schedule_expression = "cron(0/5 * * * ? *)"
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowEventBridgeToInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_schedule.arn
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.lambda_schedule.name
  target_id = "QuoteTarget"
  arn       = aws_lambda_function.this.arn
}
