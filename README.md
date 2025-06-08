# AWS Infrastructure Showcase with Terraform

This is a simple infrastructure demonstration using Terraform that creates:
- EC2 instance with Nginx web server
- Application Load Balancer (ALB)
- Security Group for HTTP access

## Prerequisites

1. AWS CLI configured with appropriate credentials
2. Create an S3 bucket for Terraform state storage

```bash
aws s3 mb s3://tf-showcase-state-yourname-123 --region us-west-1
```

## Usage

1. Replace `yourname-123` in main.tf S3 bucket name with your identifier
2. Run `terraform init` to initialize the working directory
3. Run `terraform apply` to create the infrastructure

Once complete, you can access the web server through the ALB URL shown in the Terraform output.

The web page will display:
- Infrastructure details
- Instance metadata
- Explanation of how Terraform works

This is a great conversation starter for discussing:
- Infrastructure as Code concepts
- AWS services
- Terraform usage
- Web server configuration

## Cleanup

To remove all resources when you're done:
```bash
terraform destroy
```