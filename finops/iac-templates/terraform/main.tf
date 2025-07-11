# Main Terraform configuration for OpenOps AWS Integration
# ECS Deployment: openops-finops-cluster
# Account: 052236698216

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Project     = "OpenOps-FinOps-Evaluation"
      Environment = "evaluation"
      ManagedBy   = "terraform"
      Deployment  = "ECS-Fargate"
    }
  }
}

# Data sources for existing OpenOps VPC
data "aws_vpc" "openops" {
  filter {
    name   = "tag:Name"
    values = ["OpenOps-vpc"]
  }
}

data "aws_subnets" "openops" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.openops.id]
  }
}

# IAM Task Role for OpenOps
module "iam_role" {
  source = "./modules/iam-role"
  
  openops_role_name = "openops-ecs-task-role"
  tags              = var.common_tags
}

# ECS Cluster for OpenOps
module "ecs_cluster" {
  source = "./modules/ecs-cluster"
  
  region                 = var.aws_region
  vpc_id                = data.aws_vpc.openops.id
  vpc_cidr              = data.aws_vpc.openops.cidr_block
  private_subnet_ids    = data.aws_subnets.openops.ids
  openops_task_role_arn = module.iam_role.role_arn
  openops_ecs_sg_id     = "sg-05d7b63b03cb05538"
  tags                  = var.common_tags
}

# CloudWatch Events Integration
module "cloudwatch_events" {
  source = "./modules/cloudwatch-events"
  
  region     = var.aws_region
  account_id = var.aws_account_id
  tags       = var.common_tags
}

# Cost Explorer Budget (for cost threshold alerts)
resource "aws_budgets_budget" "openops_daily_budget" {
  name         = "openops-daily-budget"
  budget_type  = "COST"
  limit_amount = "1000"
  limit_unit   = "USD"
  time_unit    = "DAILY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                 = 80
    threshold_type            = "PERCENTAGE"
    notification_type         = "ACTUAL"
    subscriber_email_addresses = [var.notification_email]
  }
}

# Outputs
output "ecs_cluster_name" {
  description = "Name of the OpenOps ECS cluster"
  value       = module.ecs_cluster.cluster_name
}

output "ecs_service_name" {
  description = "Name of the OpenOps ECS service"
  value       = module.ecs_cluster.service_name
}

output "iam_policy_arn" {
  description = "ARN of the OpenOps automation policy"
  value       = module.iam_role.policy_arn
}

output "iam_role_arn" {
  description = "ARN of the OpenOps ECS task role"
  value       = module.iam_role.role_arn
}

output "sns_topic_arn" {
  description = "ARN of the OpenOps SNS topic"
  value       = module.cloudwatch_events.sns_topic_arn
}

output "budget_name" {
  description = "Name of the created budget"
  value       = aws_budgets_budget.openops_daily_budget.name
}

output "alb_dns_name" {
  value = module.ecs_cluster.alb_dns_name
}