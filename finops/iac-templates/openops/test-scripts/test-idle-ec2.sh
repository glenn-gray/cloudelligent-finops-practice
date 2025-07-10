#!/bin/bash
# Test Idle EC2 Detection Workflow

echo "=== Testing Idle EC2 Detection ==="

DRY_RUN=${1:-"--dry-run"}

echo "Mode: $DRY_RUN"
echo "Checking for idle EC2 instances..."

# Get instances with low CPU utilization
aws ec2 describe-instances \
  --filters "Name=instance-state-name,Values=running" \
  --query 'Reservations[].Instances[].[InstanceId,InstanceType,LaunchTime,Tags[?Key==`Name`].Value|[0]]' \
  --output table

echo ""
echo "Checking CloudWatch metrics for CPU utilization..."

# Check current running instance as example
INSTANCE_ID="i-04216b668db9a2b73"
END_TIME=$(date -u +"%Y-%m-%dT%H:%M:%S")
START_TIME=$(date -u -d '24 hours ago' +"%Y-%m-%dT%H:%M:%S")

echo "Checking CPU metrics for $INSTANCE_ID (last 24 hours)..."
aws cloudwatch get-metric-statistics \
  --namespace AWS/EC2 \
  --metric-name CPUUtilization \
  --dimensions Name=InstanceId,Value=$INSTANCE_ID \
  --start-time $START_TIME \
  --end-time $END_TIME \
  --period 3600 \
  --statistics Average \
  --query 'Datapoints[].{Time:Timestamp,CPU:Average}' \
  --output table

if [ "$DRY_RUN" = "--execute" ]; then
    echo "⚠️ EXECUTE mode not implemented - would stop idle instances"
else
    echo "✅ Dry run complete - no instances modified"
fi

echo ""
echo "Next: Configure idle detection policy with <5% CPU threshold"