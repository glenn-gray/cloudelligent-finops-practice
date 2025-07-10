#!/bin/bash
# Deploy OpenOps ECS Infrastructure
# VPC: OpenOps-vpc (vpc-00bdf7ab7f4ef7ba8)

set -e

echo "=== OpenOps ECS Deployment ==="
echo "Account: 052236698216"
echo "Region: us-east-1"
echo "VPC: OpenOps-vpc (vpc-00bdf7ab7f4ef7ba8)"

# Initialize Terraform
echo "1. Initializing Terraform..."
terraform init

# Validate configuration
echo "2. Validating Terraform configuration..."
terraform validate

# Plan deployment
echo "3. Planning ECS deployment..."
terraform plan -out=openops-ecs.tfplan

# Apply deployment (with confirmation)
echo "4. Applying ECS deployment..."
read -p "Deploy OpenOps ECS infrastructure? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    terraform apply openops-ecs.tfplan
    echo "✅ ECS deployment complete!"
else
    echo "❌ Deployment cancelled"
    exit 1
fi

# Validate deployment
echo "5. Validating ECS deployment..."
echo "Checking ECS cluster..."
aws ecs describe-clusters --clusters openops-finops-cluster

echo "Checking ECS service..."
aws ecs describe-services --cluster openops-finops-cluster --services openops-finops-service

echo "Testing task permissions..."
TASK_ARN=$(aws ecs list-tasks --cluster openops-finops-cluster --service-name openops-finops-service --query 'taskArns[0]' --output text)
if [ "$TASK_ARN" != "None" ]; then
    echo "Task running: $TASK_ARN"
else
    echo "⚠️ No tasks running yet"
fi

echo ""
echo "=== Deployment Summary ==="
terraform output

echo ""
echo "Next steps:"
echo "1. Verify ECS service is running and healthy"
echo "2. Test AWS permissions from ECS task"
echo "3. Configure Slack webhook integration"
echo "4. Begin Phase 2 use case implementation"