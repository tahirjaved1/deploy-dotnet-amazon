terraform {
  backend "s3" {
    bucket = "testcronjob"
    key    = "terraform.tfstate"
    region = "eu-north-1"
  }
}