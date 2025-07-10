variable "openops_role_name" {
  description = "Name of the OpenOps ECS task role"
  type        = string
  default     = "openops-ecs-task-role"
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