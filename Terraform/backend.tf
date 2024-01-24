terraform {
  backend "s3" {
    bucket = "testcronjob"
    key    = "terraform.tfstate"
  }
}