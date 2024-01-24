variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "eu-north-1"
}

variable "aws_s3" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "testcronjob"
}


variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "The EC2 instance type."
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "The name of the SSH key pair."
  type        = string
  default = "testinstance"
}

variable "sonarqube_ami" {
  description = "The AMI ID for the SonarQube EC2 instance."
  type        = string
  default     = "ami-0014ce3e52359afbd"
}

variable "nexus_ami" {
  description = "The AMI ID for the Nexus EC2 instance."
  type        = string
  default     = "ami-0014ce3e52359afbd"
}

variable "deployment_ami" {
  description = "The AMI ID for the Deployment EC2 instance."
  type        = string
  default     = "ami-0014ce3e52359afbd"
}
