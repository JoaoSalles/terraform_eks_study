terraform {
    required_version = ">=0.13.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.54.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.2"
    }
  }
  backend "s3" {
    bucket = "terraform.fullcycle"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}