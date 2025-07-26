terraform {
  required_version = "~> 1.1"

  required_providers {
    # https://search.opentofu.org/provider/hashicorp/aws/latest
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.16.1"
    }
  }

  # https://opentofu.org/docs/language/settings/backends/s3/
  backend "s3" {
    bucket         = "architectf"
    key            = "minecraft"
    region         = "us-east-1"
    dynamodb_table = "architectf-timeline"
  }
}

# https://search.opentofu.org/provider/hashicorp/aws/latest#aws-provider
provider "aws" {
  region = "us-east-1"
}
