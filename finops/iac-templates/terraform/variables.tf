variable "aws_region" {
  description = "AWS region for OpenOps deployment"
  type        = string
  default     = "us-east-1"
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
  default     = "052236698216"
}

variable "openops_cluster_name" {
  description = "OpenOps ECS cluster name"
  type        = string
  default     = "openops-finops-cluster"
}

variable "openops_service_name" {
  description = "OpenOps ECS service name"
  type        = string
  default     = "openops-finops-service"
}

variable "openops_role_name" {
  description = "Name of the OpenOps ECS task role"
  type        = string
  default     = "openops-ecs-task-role"
}

variable "notification_email" {
  description = "Email for budget notifications"
  type        = string
  default     = "glenn.gray@cloudelligent.com"
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Project     = "OpenOps-FinOps-Evaluation"
    Environment = "evaluation"
    Owner       = "cloudelligent"
    Deployment  = "ECS-Fargate"
  }
}