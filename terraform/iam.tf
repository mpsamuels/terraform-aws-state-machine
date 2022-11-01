resource "aws_iam_role" "state_machine_role" {
  name               = "${var.prefix_name}-state-machine-role"
  assume_role_policy = file("${path.module}/templates/state_machine_sts_policy.tpl")
}

resource "aws_iam_role_policy" "cloudwatch_logs_policy" {
  name   = "${var.prefix_name}-cloudwatch-logs-policy"
  role   = aws_iam_role.state_machine_role.name
  policy = file("${path.module}/templates/cloudwatch_logs_policy.tpl")
}

resource "aws_iam_role_policy" "state_machine_policy" {
  name   = "${var.prefix_name}-state-machine-policy"
  role   = aws_iam_role.state_machine_role.name
  policy = var.policy
}

resource "aws_iam_role" "event_bridge_role" {
  name               = "${var.prefix_name}-event-bridge-role"
  assume_role_policy = file("${path.module}/templates/event_bridge_sts_policy.tpl")
}

resource "aws_iam_role_policy" "state_macine_execution_policy" {
  name   = "${var.prefix_name}-event-bridge-policy"
  role   = aws_iam_role.event_bridge_role.id
  policy = templatefile("${path.module}/templates/state_machine_execution_policy.tpl", { region = data.aws_region.current.name, account = data.aws_caller_identity.current.account_id, state_machine = aws_sfn_state_machine.sfn_state_machine.name })
}


