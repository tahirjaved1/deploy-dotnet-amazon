# AWS Region where resources will be created
variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "eu-north-1"
}

# Name of the AWS S3 bucket
variable "aws_s3" {
  description = "The name of the AWS S3 bucket."
  type        = string
  default     = "testcronjob"
}

# CIDR block for the VPC
variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

# CIDR block for the subnet
variable "subnet_cidr" {
  description = "The CIDR block for the subnet."
  type        = string
  default     = "10.0.1.0/24"
}

# EC2 instance type
variable "instance_type" {
  description = "The EC2 instance type."
  type        = string
  default     = "t3.medium"
}

# Name of the SSH key pair
variable "key_name" {
  description = "The name of the SSH key pair."
  type        = string
  default     = "testinstance"
}

# AMI ID for the SonarQube EC2 instance
variable "sonarqube_ami" {
  description = "The AMI ID for the SonarQube EC2 instance."
  type        = string
  default     = "ami-0014ce3e52359afbd"
}

# AMI ID for the Nexus EC2 instance
variable "nexus_ami" {
  description = "The AMI ID for the Nexus EC2 instance."
  type        = string
  default     = "ami-0014ce3e52359afbd"
}

# AMI ID for the Deployment EC2 instance
variable "deployment_ami" {
  description = "The AMI ID for the Deployment EC2 instance."
  type        = string
  default     = "ami-0014ce3e52359afbd"
}
