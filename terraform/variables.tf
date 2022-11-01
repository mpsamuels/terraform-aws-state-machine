variable "prefix_name" {
  type        = string
  description = "Name to prefix to resources."
}
variable "create_cloudwatch_event_rule" {
  type        = bool
  default     = true
  description = "Boolean: Whether to create cloudwatch event rule to monitor new files in S3 bucket. Set to false if uploads are being handled by other services i.e Lambda, before being sent to State Machine"
}

variable "upload_bucket_name" {
  type        = string
  default     = ""
  description = "Name of S3 bucket Rekognition should read files from"
}

variable "definition" {
  type        = string
  description = "Name of S3 bucket Rekognition should read files from"
}

variable "policy" {
  type        = string
  description = "Name of S3 bucket Rekognition should read files from"
}
