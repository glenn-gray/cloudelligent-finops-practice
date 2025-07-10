# OpenOps Terraform Infrastructure

**Instance**: i-04216b668db9a2b73 | **Account**: 052236698216 | **Status**: ✅ Deployed

## Quick Deploy

```bash
terraform init
terraform plan
terraform apply
```

## Resources Created

- **IAM Policy**: OpenOpsAutomationPolicy (attached to openops-instance-role)
- **CloudWatch Events**: EC2, EBS, Cost Anomaly detection
- **SNS Topic**: openops-finops-notifications
- **Budget**: $1000 daily threshold with email alerts

## Validation

```bash
# Test permissions from OpenOps instance
aws sts get-caller-identity
aws ce get-cost-and-usage --time-period Start=2025-07-01,End=2025-07-08
aws ec2 describe-instances --instance-ids i-04216b668db9a2b73
aws s3 ls
```

## Modules

- `modules/iam-role/` - Enhanced automation permissions
- `modules/cloudwatch-events/` - Event rules and SNS integration

**Status**: Infrastructure deployed successfully. OpenOps instance has enhanced AWS permissions for Phase 2 automation.