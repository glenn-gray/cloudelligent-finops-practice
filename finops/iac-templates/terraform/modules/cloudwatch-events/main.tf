# CloudWatch Event Rules for OpenOps Integration
# Target: i-04216b668db9a2b73 (10.0.130.121:8080)

# EC2 State Change Events
resource "aws_cloudwatch_event_rule" "ec2_state_change" {
  name        = "openops-ec2-state-change"
  description = "Capture EC2 instance state changes for OpenOps"

  event_pattern = jsonencode({
    source      = ["aws.ec2"]
    detail-type = ["EC2 Instance State-change Notification"]
    detail = {
      state = ["running", "stopped", "terminated"]
    }
  })

  tags = var.tags
}

# Cost Anomaly Detection Events
resource "aws_cloudwatch_event_rule" "cost_anomaly" {
  name        = "openops-cost-anomaly"
  description = "Capture cost anomaly events for OpenOps"

  event_pattern = jsonencode({
    source      = ["aws.ce"]
    detail-type = ["Cost Anomaly Detection"]
  })

  tags = var.tags
}

# EBS Volume Events
resource "aws_cloudwatch_event_rule" "ebs_events" {
  name        = "openops-ebs-events"
  description = "Capture EBS volume events for OpenOps"

  event_pattern = jsonencode({
    source      = ["aws.ec2"]
    detail-type = ["EBS Volume Notification"]
    detail = {
      state = ["available", "in-use", "deleting"]
    }
  })

  tags = var.tags
}

# SNS Target for OpenOps events (simplified approach)
resource "aws_cloudwatch_event_target" "openops_ec2" {
  rule      = aws_cloudwatch_event_rule.ec2_state_change.name
  target_id = "OpenOpsEC2Target"
  arn       = aws_sns_topic.openops_notifications.arn
}

# SNS Topic for OpenOps notifications (alternative to HTTP)
resource "aws_sns_topic" "openops_notifications" {
  name = "openops-finops-notifications"
  tags = var.tags
}

# SNS Target for events
resource "aws_cloudwatch_event_target" "openops_sns" {
  rule      = aws_cloudwatch_event_rule.ec2_state_change.name
  target_id = "OpenOpsSNSTarget"
  arn       = aws_sns_topic.openops_notifications.arn
}

# Output SNS topic ARN
output "sns_topic_arn" {
  value = aws_sns_topic.openops_notifications.arn
}

output "event_rules" {
  value = {
    ec2_state_change = aws_cloudwatch_event_rule.ec2_state_change.name
    cost_anomaly     = aws_cloudwatch_event_rule.cost_anomaly.name
    ebs_events       = aws_cloudwatch_event_rule.ebs_events.name
  }
}

resource "aws_cloudwatch_event_rule" "rds_idle" {
  name        = "openops-rds-idle"
  description = "Detect idle RDS instances for OpenOps"

  event_pattern = jsonencode({
    source      = ["aws.rds"]
    detail-type = ["AWS API Call via CloudTrail"]
    detail = {
      eventName = ["DescribeDBInstances"]
    }
  })

  tags = var.tags
}

resource "aws_cloudwatch_event_rule" "idle_ec2_rule" {
  name        = "IdleEC2Detection"
  description = "Detect idle EC2 instances"
  event_pattern = jsonencode({
    "source": ["aws.ec2"],
    "detail-type": ["AWS API Call via CloudTrail"],
    "detail": {
      "eventName": ["DescribeInstances"]
    }
  })
}

resource "aws_cloudwatch_event_rule" "idle_ebs_rule" {
  name        = "UnattachedEBSDetection"
  description = "Detect unattached EBS volumes"
  event_pattern = jsonencode({
    "source": ["aws.ec2"],
    "detail-type": ["AWS API Call via CloudTrail"],
    "detail": {
      "eventName": ["DescribeVolumes"]
    }
  })
}