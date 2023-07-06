#----------------------------------------------------------
#  Provision EC2 instances with Jenkins  
#
#  Date: 06.07.23 08.40 P.M 
#
#  Made by Mustofa Kodirov
#----------------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.74"
    }
  }
}

provider "aws" {
  region     = "${var.region}"
  # access_key = var.access_key
  # secret_key = var.secret_key
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

resource "aws_ecr_repository" "ecr" {
  name                 = var.ecr_name
  image_tag_mutability = var.image_mutability
  encryption_configuration {
    encryption_type = var.encrypt_type
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = var.tags
}