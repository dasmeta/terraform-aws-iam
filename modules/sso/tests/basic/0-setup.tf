terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.41"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region = "eu-central-1"
}
