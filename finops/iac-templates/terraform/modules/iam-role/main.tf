# IAM Role and Policies for OpenOps Instance
# Instance: i-04216b668db9a2b73

# Enhanced IAM policy for OpenOps automation
resource "aws_iam_policy" "openops_automation" {
  name        = "OpenOpsAutomationPolicy"
  description = "Policy for OpenOps FinOps automation"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          # EC2 permissions
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceStatus",
          "ec2:StopInstances",
          "ec2:StartInstances",
          "ec2:DescribeVolumes",
          "ec2:CreateSnapshot",
          "ec2:DeleteVolume",
          "ec2:CreateTags",
          "ec2:DescribeTags",
          
          # S3 permissions
          "s3:ListAllMyBuckets",
          "s3:GetBucketPolicy",
          "s3:PutBucketPolicy",
          "s3:GetBucketAcl",
          "s3:PutBucketAcl",
          
          # CloudWatch permissions
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:ListMetrics",
          "cloudwatch:PutMetricData",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          
          # Cost Explorer permissions
          "ce:GetCostAndUsage",
          "ce:GetUsageReport",
          "ce:GetReservationCoverage",
          "ce:GetReservationPurchaseRecommendation",
          "ce:GetReservationUtilization",
          
          # Config permissions
          "config:GetComplianceDetailsByConfigRule",
          "config:GetComplianceDetailsByResource",
          "config:DescribeConfigRules",
          
          # Bedrock permissions
          "bedrock:InvokeModel",
          "bedrock:ListFoundationModels"
        ]
        Resource = "*"
      }
    ]
  })
}

# Create ECS Task Role
resource "aws_iam_role" "openops_task" {
  name = var.openops_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

# Attach policy to ECS task role
resource "aws_iam_role_policy_attachment" "openops_automation" {
  role       = aws_iam_role.openops_task.name
  policy_arn = aws_iam_policy.openops_automation.arn
}

# Outputs
output "policy_arn" {
  value = aws_iam_policy.openops_automation.arn
}

output "role_arn" {
  value = aws_iam_role.openops_task.arn
}