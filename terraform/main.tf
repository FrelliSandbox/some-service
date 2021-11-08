terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  backend "s3" {
    region = "eu-west-1"
    profile = "terraform-user"
    bucket = "frellisandbox-terraform-state"
    key = "some-service.tfstate"
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "terraform-user"
  region  = "eu-west-1"
}
