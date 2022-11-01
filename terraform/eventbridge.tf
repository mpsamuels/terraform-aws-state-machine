resource "aws_cloudwatch_event_rule" "on_s3_upload" {
  count         = var.create_cloudwatch_event_rule == true ? 1 : 0
  name          = "${var.prefix_name}-eventbridge-rule"
  event_pattern = templatefile("${path.module}/templates/s3_cloudwatch_event.tpl", { bucket = var.upload_bucket_name })
}

resource "aws_cloudwatch_event_target" "lambda_event_target" {
  count     = var.create_cloudwatch_event_rule == true ? 1 : 0
  target_id = "${var.prefix_name}-eventbridge-target"
  rule      = aws_cloudwatch_event_rule.on_s3_upload[count.index].name
  arn       = aws_sfn_state_machine.sfn_state_machine.arn
  role_arn  = aws_iam_role.event_bridge_role.arn
}