terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.9.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}