# Main Terraform configuration for OpenOps AWS Integration
# Instance: i-04216b668db9a2b73
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
      Instance    = "i-04216b668db9a2b73"
    }
  }
}

# IAM Role Enhancement
module "iam_role" {
  source = "./modules/iam-role"
  
  openops_role_name = var.openops_role_name
  tags              = var.common_tags
}

# CloudWatch Events Integration
module "cloudwatch_events" {
  source = "./modules/cloudwatch-events"
  
  region               = var.aws_region
  account_id          = var.aws_account_id
  openops_instance_ip = var.openops_instance_ip
  tags                = var.common_tags
}

# Cost Explorer Budget (for cost threshold alerts)
resource "aws_budgets_budget" "openops_daily_budget" {
  name         = "openops-daily-budget"
  budget_type  = "COST"
  limit_amount = "1000"
  limit_unit   = "USD"
  time_unit    = "DAILY"
  
  cost_filters = {
    Service = ["Amazon Elastic Compute Cloud - Compute"]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                 = 80
    threshold_type            = "PERCENTAGE"
    notification_type         = "ACTUAL"
    subscriber_email_addresses = [var.notification_email]
  }
}

# Outputs
output "iam_policy_arn" {
  description = "ARN of the OpenOps automation policy"
  value       = module.iam_role.policy_arn
}

output "sns_topic_arn" {
  description = "ARN of the OpenOps SNS topic"
  value       = module.cloudwatch_events.sns_topic_arn
}

output "event_rules" {
  description = "CloudWatch event rules created"
  value       = module.cloudwatch_events.event_rules
}

output "budget_name" {
  description = "Name of the created budget"
  value       = aws_budgets_budget.openops_daily_budget.name
}