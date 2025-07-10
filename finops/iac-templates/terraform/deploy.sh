#!/bin/bash
# Deploy OpenOps AWS Integration via Terraform
# Instance: i-04216b668db9a2b73

set -e

echo "=== OpenOps AWS Integration Deployment ==="
echo "Instance: i-04216b668db9a2b73"
echo "Account: 052236698216"
echo "Region: us-east-1"

# Initialize Terraform
echo "1. Initializing Terraform..."
terraform init

# Validate configuration
echo "2. Validating Terraform configuration..."
terraform validate

# Plan deployment
echo "3. Planning deployment..."
terraform plan -out=openops-integration.tfplan

# Apply deployment (with confirmation)
echo "4. Applying deployment..."
read -p "Deploy OpenOps AWS integration? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    terraform apply openops-integration.tfplan
    echo "✅ Deployment complete!"
else
    echo "❌ Deployment cancelled"
    exit 1
fi

# Validate deployment
echo "5. Validating deployment..."
echo "Testing IAM permissions..."
aws sts get-caller-identity

echo "Testing Cost Explorer access..."
aws ce get-cost-and-usage --time-period Start=2025-07-01,End=2025-07-08 --granularity DAILY --metrics BlendedCost || echo "⚠️ Cost Explorer access limited"

echo "Testing EC2 permissions..."
aws ec2 describe-instances --instance-ids i-04216b668db9a2b73 || echo "⚠️ EC2 access limited"

echo ""
echo "=== Deployment Summary ==="
terraform output

echo ""
echo "Next steps:"
echo "1. Test CloudWatch event integration"
echo "2. Configure Slack webhook notifications"
echo "3. Validate policy automation workflows"
echo "4. Begin Phase 2 use case testing"