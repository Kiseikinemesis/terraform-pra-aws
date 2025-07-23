terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      map-migrated = var.map_migrated_tag
      Environment  = var.environment
      Project      = var.project_name
    }
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

#DATA

data "aws_security_group" "global" {
  name = var.global_sg_name
}

data "aws_security_group" "global_app" {
  name = var.global_app_sg_name
}

data "aws_iam_instance_profile" "basic" {
  name = var.iam_instance_profile_name
}

data "aws_vpc" "main" {
  tags = {
    Name = var.main_vpc_name
  }
}

data "aws_vpc" "vpc" {
  tags = {
    Name = "${var.company_name}-vpc"
  }
}

data "aws_subnets" "private_az_1" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = [var.private_az1_subnet_name]
  }
}

data "aws_subnets" "private_az_2" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = [var.private_az2_subnet_name]
  }
}

data "aws_subnets" "private_az_3" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = [var.private_az3_subnet_name]
  }
}

data "aws_subnets" "second_private_az_1" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = [var.second_private_az1_subnet_name]
  }
}

data "aws_subnets" "public_az_1" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = [var.public_az1_subnet_name]
  }
}

data "aws_subnets" "public_az_2" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = [var.public_az2_subnet_name]
  }
}

data "aws_subnets" "public_az_3" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = [var.public_az3_subnet_name]
  }
}

data "aws_subnets" "publics" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }

  filter {
    name   = "tag:Name"
    values = [var.public_az_wildcard_subnet_name]
  }
}

data "aws_subnet" "public" {
  for_each = toset(data.aws_subnets.publics.ids)

  vpc_id = data.aws_vpc.main.id
  id     = each.value
}

data "aws_route53_zone" "zone_exemple_cloud" {
  name         = var.route53_zone_name
  private_zone = false
}

data "aws_instance" "ec2_instance_haproxy" {
  filter {
    name   = "tag:Name"
    values = [var.ec2_instance_haproxy_name]
  }
}

data "aws_instance" "ec2_instance_haproxy_2" {
  filter {
    name   = "tag:Name"
    values = [var.ec2_instance_haproxy_2_name]
  }
}
