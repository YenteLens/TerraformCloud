terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "yentelensfinalproject"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"
}
