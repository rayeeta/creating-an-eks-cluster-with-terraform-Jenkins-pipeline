############################
# Provider Configuration
############################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.20.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = "us-west-2"
}
