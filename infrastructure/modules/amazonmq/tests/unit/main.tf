// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "test-vpc-dev"
  cidr = "10.10.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  public_subnets  = ["10.10.101.0/24", "10.10.102.0/24", "10.10.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "main" {
  source = "../.."
  APP                   = "test"
  COMPONENT             = "comp"
  ENV                   = "dev"
  HOST_INSTANCE_TYPE    = "mq.m5.large"
  VPC_ID                = module.vpc.vpc_id
  SUBNET_IDS            = module.vpc.public_subnets
}

locals {
  broker_arn = module.main.broker_arn
  broker_instances = module.main.broker_instances
}