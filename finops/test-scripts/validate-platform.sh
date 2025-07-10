#!/bin/bash
# OpenOps Platform Validation Script

echo "=== OpenOps Platform Validation ==="
echo "Instance: i-04216b668db9a2b73"
echo "Account: 052236698216"

# Test 1: Platform Health Check
echo "1. Testing OpenOps platform health..."
curl -f http://10.0.130.121:8080/health && echo "✅ Platform healthy" || echo "❌ Platform not responding"

# Test 2: AWS Connectivity
echo "2. Testing AWS connectivity..."
aws sts get-caller-identity --region us-east-1 && echo "✅ AWS access working" || echo "❌ AWS access failed"

# Test 3: IAM Role Validation
echo "3. Validating IAM role permissions..."
aws iam get-role --role-name openops-instance-role --region us-east-1 && echo "✅ IAM role exists" || echo "❌ IAM role not found"

# Test 4: EC2 Permissions
echo "4. Testing EC2 permissions..."
aws ec2 describe-instances --instance-ids i-04216b668db9a2b73 --region us-east-1 > /dev/null && echo "✅ EC2 access working" || echo "❌ EC2 access failed"

# Test 5: Cost Explorer Access
echo "5. Testing Cost Explorer access..."
aws ce get-cost-and-usage --time-period Start=2025-07-01,End=2025-07-08 --granularity DAILY --metrics BlendedCost --region us-east-1 > /dev/null && echo "✅ Cost Explorer access working" || echo "❌ Cost Explorer access failed"

# Test 6: Slack Integration
echo "6. Testing Slack webhook (if configured)..."
if [ ! -z "$SLACK_WEBHOOK_URL" ]; then
    curl -X POST -H 'Content-type: application/json' --data '{"text":"OpenOps validation test"}' $SLACK_WEBHOOK_URL && echo "✅ Slack integration working" || echo "❌ Slack integration failed"
else
    echo "⚠️ SLACK_WEBHOOK_URL not configured"
fi

# Test 7: Policy Engine
echo "7. Testing policy engine..."
if [ -f "/etc/openops/policies/idle-ec2-policy.json" ]; then
    echo "✅ Policy files found"
else
    echo "⚠️ Policy files not deployed"
fi

echo ""
echo "=== Validation Summary ==="
echo "Run this script on the OpenOps instance to validate configuration"
echo "Required environment variables:"
echo "- SLACK_WEBHOOK_URL"
echo "- JIRA_API_TOKEN"
echo "- GITHUB_TOKEN"