<a name="readme-top"></a>

# Terraform AWS S3 to Rekognition Module

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-the-project">About The Project</a></li>
    <li><a href="#features">Features</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#requirements">Terraform Docs</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

A terraform module for AWS that provisions a Step Functions State Machine, IAM polidy permissions for use by the State Machine and, optionally, event bridge notification from a named S3 bucket to initiate the State Machine on object upload.

The State Machine and IAM policy must be passed as templatefile arguments.

![Design diagram](/state_machine.png)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- FEATURES -->
## Features

The module deploys the following AWS infrastructure:
* 1x Step Functions State Machine
* 2x IAM role with IAM policies attached
* 1x S3 Bucket Notification configuration to enable Event Bridge (optional via boolean variable)
* 1x Event Bridge Rule and Target (optional via boolean variable)


<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE -->
## Usage

```hcl
module "terraform-aws-s3-images-to-rekognition" {
  source = "terraform-aws-s3-to-rekognition"

  prefix_name                  = "indentifiable-string-to-prefix-to-resource-names"
  create_cloudwatch_event_rule = boolean to declare whether S3 notification should be enabled
  upload_bucket_name           = aws_s3_bucket.s3.bucket
  definition                   = templatefile(path_to_state_machine_templatefile, {arguments})
  policy                       = templatefile(path_to_IAM_Policy_templatefile, {arguments})
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/mpsamuels/terraform-aws-state-machine/issues) for a full list of proposed features and known issues.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- REQUIREMENTS -->

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.on_s3_upload](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.lambda_event_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_group.state_machine_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.event_bridge_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.state_machine_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.cloudwatch_logs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.state_machine_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.state_macine_execution_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_s3_bucket_notification.bucket_notification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |
| [aws_sfn_state_machine.sfn_state_machine](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sfn_state_machine) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_cloudwatch_event_rule"></a> [create\_cloudwatch\_event\_rule](#input\_create\_cloudwatch\_event\_rule) | Boolean: Whether to create cloudwatch event rule to monitor new files in S3 bucket. Set to false if uploads are being handled by other services i.e Lambda, before being sent to State Machine | `bool` | `true` | no |
| <a name="input_definition"></a> [definition](#input\_definition) | Name of S3 bucket Rekognition should read files from | `string` | n/a | yes |
| <a name="input_policy"></a> [policy](#input\_policy) | Name of S3 bucket Rekognition should read files from | `string` | n/a | yes |
| <a name="input_prefix_name"></a> [prefix\_name](#input\_prefix\_name) | Name to prefix to resources. | `string` | n/a | yes |
| <a name="input_upload_bucket_name"></a> [upload\_bucket\_name](#input\_upload\_bucket\_name) | Name of S3 bucket Rekognition should read files from | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_sfn_state_machine"></a> [aws\_sfn\_state\_machine](#output\_aws\_sfn\_state\_machine) | ARN of state machine |