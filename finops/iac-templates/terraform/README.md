# OpenOps AWS Integration - Terraform Modules

**Instance**: i-04216b668db9a2b73 (t3.large, us-east-1a)  
**Account**: 052236698216  
**Purpose**: Configure AWS service integrations for OpenOps platform

## Modules

### 1. IAM Role (`modules/iam-role/`)
- Enhances existing `openops-instance-role` with automation permissions
- Grants access to EC2, S3, CloudWatch, Cost Explorer, Config, Bedrock
- Follows least privilege principle

### 2. CloudWatch Events (`modules/cloudwatch-events/`)
- Creates event rules for EC2 state changes, cost anomalies, EBS events
- Sets up SNS topic for notifications
- Configures targets for OpenOps integration

## Quick Deployment

```bash
# Navigate to terraform directory
cd finops/iac-templates/terraform

# Deploy all modules
./deploy.sh

# Or manual deployment
terraform init
terraform plan
terraform apply
```

## Validation Commands

After deployment, test from OpenOps instance:

```bash
# Test IAM permissions
aws sts get-caller-identity

# Test Cost Explorer
aws ce get-cost-and-usage --time-period Start=2025-07-01,End=2025-07-08 --granularity DAILY --metrics BlendedCost

# Test EC2 permissions
aws ec2 describe-instances --instance-ids i-04216b668db9a2b73

# Test S3 access
aws s3 ls

# Test CloudWatch
aws logs describe-log-groups --limit 5
```

## Resources Created

- **IAM Policy**: OpenOpsAutomationPolicy
- **CloudWatch Event Rules**: EC2, Cost Anomaly, EBS events
- **SNS Topic**: openops-finops-notifications
- **Budget**: openops-daily-budget ($1000 daily limit)

## Integration Points

- **CloudWatch Events** → **SNS Topic** → **OpenOps Webhook**
- **Cost Explorer API** → **OpenOps Cost Analysis**
- **EC2 API** → **OpenOps Instance Management**
- **S3 API** → **OpenOps Security Remediation**

## Next Steps

1. Deploy Terraform modules
2. Test AWS service connectivity
3. Configure Slack webhook integration
4. Implement Phase 2 use cases
5. Validate end-to-end workflows

---

**Status**: Ready for deployment to enhance OpenOps AWS integration capabilities