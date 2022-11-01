output "aws_sfn_state_machine" {
  description = "ARN of state machine"
  value       = aws_sfn_state_machine.sfn_state_machine.arn
}