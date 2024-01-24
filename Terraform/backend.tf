terraform {
  backend "s3" {
    bucket = var.aws_s3
    key    = "terraform.tfstate"
    region = var.aws_region
  }
}
