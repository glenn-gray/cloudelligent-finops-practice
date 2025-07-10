# OpenOps ECS Infrastructure

**Deployment**: ECS Fargate | **Account**: 052236698216 | **Status**: ✅ Ready for Deploy

## Quick Deploy

```bash
terraform init
terraform plan
terraform apply
```

## Resources Created

- **ECS Cluster**: openops-finops-cluster (Fargate)
- **ECS Service**: openops-finops-service (1 task)
- **IAM Role**: openops-ecs-task-role with OpenOpsAutomationPolicy
- **CloudWatch Events**: EC2, EBS, Cost Anomaly detection
- **SNS Topic**: openops-finops-notifications
- **Budget**: $1000 daily threshold with email alerts

## Validation

```bash
# Test ECS service
aws ecs describe-services --cluster openops-finops-cluster --services openops-finops-service

# Test permissions from ECS task
aws ecs execute-command --cluster openops-finops-cluster --task <task-id> --interactive --command "/bin/bash"
aws sts get-caller-identity
aws ce get-cost-and-usage --time-period Start=2025-07-01,End=2025-07-08
```

## Modules

- `modules/ecs-cluster/` - ECS Fargate cluster and service
- `modules/iam-role/` - ECS task role with automation permissions
- `modules/cloudwatch-events/` - Event rules and SNS integration

**Status**: ECS infrastructure ready for deployment. OpenOps will run as containerized service with enhanced AWS permissions.