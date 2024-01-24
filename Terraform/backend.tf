terraform {
  backend "s3" {
    bucket = "testcronjob"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}