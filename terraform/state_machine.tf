resource "aws_sfn_state_machine" "sfn_state_machine" {
  name       = "${var.prefix_name}-state-machine"
  role_arn   = aws_iam_role.state_machine_role.arn
  definition = var.definition
  logging_configuration {
    log_destination        = "${aws_cloudwatch_log_group.state_machine_log_group.arn}:*"
    include_execution_data = true
    level                  = "ERROR"
  }
}

resource "aws_cloudwatch_log_group" "state_machine_log_group" {
  name              = "/aws/${var.prefix_name}-state-machine-lg"
  retention_in_days = 30
}