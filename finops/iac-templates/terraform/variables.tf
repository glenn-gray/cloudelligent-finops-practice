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

variable "openops_instance_id" {
  description = "OpenOps EC2 instance ID"
  type        = string
  default     = "i-04216b668db9a2b73"
}

variable "openops_instance_ip" {
  description = "OpenOps instance private IP"
  type        = string
  default     = "10.0.130.121"
}

variable "openops_role_name" {
  description = "Name of the existing OpenOps IAM role"
  type        = string
  default     = "openops-instance-role"
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
    Instance    = "i-04216b668db9a2b73"
  }
}