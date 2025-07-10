variable "openops_role_name" {
  description = "Name of the existing OpenOps IAM role"
  type        = string
  default     = "openops-instance-role"
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