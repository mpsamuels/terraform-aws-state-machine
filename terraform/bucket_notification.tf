resource "aws_s3_bucket_notification" "bucket_notification" {
  count       = var.create_cloudwatch_event_rule == true ? 1 : 0
  bucket      = var.upload_bucket_name
  eventbridge = true
}