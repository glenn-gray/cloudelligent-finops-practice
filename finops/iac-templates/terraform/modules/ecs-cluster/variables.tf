variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "VPC ID for ECS deployment"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for ECS tasks"
  type        = list(string)
  default = [ "subnet-05cf08af9642baef8","subnet-0c9aba56b3f8b3e81" ]
}

variable "openops_task_role_arn" {
  description = "ARN of the OpenOps task role with automation permissions"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Project     = "OpenOps-FinOps-Evaluation"
    Environment = "evaluation"
    Owner       = "cloudelligent"
  }
}

variable "openops_ecs_sg_id" {
  description = "Security Group ID for OpenOps ECS tasks and ALB"
  type        = string
  default     = "sg-05d7b63b03cb05538"
}