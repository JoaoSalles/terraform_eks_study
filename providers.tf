terraform {
    required_version = ">=0.13.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.54.0"
    }
  }
  backend "s3" {
    bucket = "terraform.fullcycle"
    key    = "terraformEC2.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}