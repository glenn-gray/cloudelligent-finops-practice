variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
  default     = "052236698216"
}

variable "openops_instance_ip" {
  description = "Private IP of OpenOps instance"
  type        = string
  default     = "10.0.130.121"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}