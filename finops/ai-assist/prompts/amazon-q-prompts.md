# Amazon Q Prompts for OpenOps Integration Evaluation

## OpenOps Platform Configuration

```
Configure existing OpenOps platform for evaluation:

Deployed Platform:
- Instance: i-04216b668db9a2b73 (us-east-1)
- Account: 052236698216
- Status: Already deployed and running
- Timeline: 14 days (July 7-18, 2025)

Configuration tasks:
1. Verify OpenOps service status on EC2 instance
2. Configure IAM permissions for automation
3. Set up AWS service integrations
4. Create initial policy templates
5. Test platform connectivity and functionality

Commands to run:
- ssh into i-04216b668db9a2b73
- sudo systemctl status openops
- Configure AWS credentials for the instance
- Test API connectivity
```

## AWS Service Integration Setup

```
Configure AWS service integrations for deployed OpenOps platform:

OpenOps Instance: i-04216b668db9a2b73
Services to integrate:
- CloudWatch (events and metrics)
- Cost Explorer (cost data)
- EC2 (instance management)
- EBS (volume management)
- S3 (bucket policies)
- AWS Config (compliance)
- Bedrock (AI optimization)

Integration steps:
1. Configure IAM role for i-04216b668db9a2b73
2. Set up CloudWatch event rules targeting OpenOps
3. Test Cost Explorer API access from instance
4. Configure service-specific permissions
5. Validate integration connectivity

Validation commands:
- aws sts get-caller-identity (from instance)
- aws ce get-cost-and-usage --time-period Start=2025-07-01,End=2025-07-08
- aws ec2 describe-instances --instance-ids i-04216b668db9a2b73
```

## Policy Engine Configuration

```
Create OpenOps policy engine rules for these use cases:

Priority Use Cases:
1. Idle EC2 detection and shutdown (>24h, <5% CPU)
2. Unattached EBS volume cleanup (>7 days)
3. Cost threshold alerts (daily spend >$1000)
4. Untagged resource enforcement
5. Public S3 bucket remediation

For each use case, generate:
1. Detection logic and thresholds
2. Approval workflow requirements
3. Remediation actions
4. Notification configurations
5. Rollback procedures

Format as OpenOps policy JSON configurations.
```

## Workflow Builder Automation

```
Design OpenOps workflow automation for evaluation:

Workflow Pattern: CloudWatch Event → Policy Evaluation → Approval → Action → Notification

Create workflows for:
1. Cost anomaly detection and response
2. Resource compliance enforcement
3. Automated rightsizing recommendations
4. Security remediation workflows
5. Budget threshold management

Include:
- Visual workflow diagrams
- Decision tree logic
- Integration points (Slack, Jira)
- Error handling and retries
- Performance optimization
```

## Bedrock AI Integration

```
Integrate AWS Bedrock AI with OpenOps for intelligent cost optimization:

AI Use Cases:
- EC2 rightsizing recommendations based on usage patterns
- Cost anomaly detection and root cause analysis
- Predictive cost modeling and alerts
- Resource optimization suggestions
- Policy effectiveness analysis

Generate:
1. Bedrock model selection (Claude, Titan)
2. API integration patterns
3. Data preprocessing requirements
4. AI prompt engineering for cost optimization
5. Response processing and action triggers

Focus on practical AI applications for 14-day evaluation.
```

## Performance Optimization

```
Optimize OpenOps platform performance for evaluation metrics:

Target Performance:
- Event processing: <30 seconds
- Remediation execution: <5 minutes
- Notification delivery: <10 seconds
- Policy evaluation: <15 seconds

Optimize:
1. CloudWatch event processing efficiency
2. AWS API call optimization
3. Database query performance
4. Workflow execution speed
5. Integration response times

Generate monitoring and alerting for performance KPIs.
```

## Troubleshooting Guidance

```
Create troubleshooting guide for OpenOps evaluation:

Common Issues:
- Platform deployment failures
- AWS permission errors
- Integration connectivity problems
- Policy execution failures
- Performance bottlenecks

For each issue, provide:
1. Symptom identification
2. Root cause analysis steps
3. Resolution procedures
4. Prevention strategies
5. Escalation procedures

Include diagnostic commands and log analysis techniques.
```

## Comparative Analysis with Archera

```
Generate comparative analysis framework for OpenOps vs Archera:

Evaluation Criteria:
- Cost savings potential (target: 15-30%)
- Automation coverage (target: >80%)
- Integration complexity
- Platform costs (licensing)
- Team adoption feasibility
- Long-term scalability

Create:
1. Feature comparison matrix
2. ROI calculation methodology
3. Risk assessment framework
4. Decision criteria weighting
5. Recommendation template

Format as executive decision document with clear go/no-go criteria.
```

## Integration Testing Scripts

```
Generate testing scripts for deployed OpenOps platform:

OpenOps Instance: i-04216b668db9a2b73
Test Categories:
1. Platform connectivity and health checks
2. AWS service integration validation
3. Policy engine functionality tests
4. End-to-end workflow testing
5. Performance benchmarking

Create test scripts:
- Platform health check: curl http://i-04216b668db9a2b73:8080/health
- AWS connectivity test from instance
- Policy execution validation
- Integration endpoint testing
- Performance monitoring setup

Validation procedures:
- SSH access to i-04216b668db9a2b73
- Service status verification
- Log file analysis
- API response testing
```

## Project Documentation Generation

```
Generate project documentation for OpenOps evaluation:

Based on project data:
- Timeline: 14 days (July 7-18, 2025)
- Team: Muhammad Waleed (PM), Glenn Gray (SA), Anas Ahmed (DevOps), Hamza Sarwar (Cloud Eng)
- Objective: OpenOps vs Archera evaluation

Create:
1. Executive summary for leadership
2. Technical implementation guide
3. Project timeline with milestones
4. Risk assessment and mitigation
5. Success metrics and KPIs
6. Final recommendation framework

Format for stakeholder communication and decision-making.
```