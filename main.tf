# S3 state storage
terraform {
  backend "s3" {
    bucket = "tf-showcase-state-yourname-123"
    key    = "state/terraform.tfstate"
    region = "us-west-1"
  }
}
