# Valuable Amazon Q Prompts for Cloudelligent

## SOW Generation Prompts

```
Analyze the following Avoma meeting transcript and generate SOW components for [CUSTOMER_NAME]:

Transcript: [PASTE_AVOMA_TRANSCRIPT]

Extract and create:
1. Project scope and objectives
2. Deliverables breakdown
3. Timeline and milestones
4. Resource requirements
5. Success criteria
6. Assumptions and constraints
7. Risk assessment
8. Pricing structure recommendations

Format as professional SOW sections with:
- Executive summary
- Technical requirements
- Implementation approach
- Acceptance criteria
```

## Architecture Documentation Generation

```
Based on this Avoma transcript, draft architecture documentation for [CUSTOMER_NAME]:

Transcript: [PASTE_AVOMA_TRANSCRIPT]

Generate:
1. Current state architecture (based on discussion)
2. Target state architecture design
3. Migration strategy and phases
4. Technology stack recommendations
5. Integration requirements
6. Security and compliance considerations
7. Scalability and performance requirements
8. Cost optimization opportunities

Include Mermaid diagrams for:
- High-level architecture
- Data flow
- Integration points
```

## Implementation Guide Creation

```
Create implementation guide based on discovered data for [CUSTOMER_NAME]:

Data: [DISCOVERED_DATA]

Develop:
1. Phase-by-phase implementation plan
2. Prerequisites and dependencies
3. Configuration steps
4. Testing and validation procedures
5. Go-live checklist
6. Post-implementation support
7. Knowledge transfer plan
8. Troubleshooting guide

Prioritize based on:
- Business impact
- Technical complexity
- Resource availability
- Risk mitigation
```

## Executive Summary Generation

```
Generate an executive summary for [CUSTOMER_NAME] stakeholders based on this discovered data:

Data: [DISCOVERED_DATA]

Include:
1. Project overview and business value
2. Key modernization benefits
3. High-level approach and timeline
4. Resource and investment summary
5. Critical success factors
6. Risk management strategy
7. Next steps and recommendations

Format for C-level executives with focus on business outcomes and ROI.
```

## Project Plan Creation

```
Create detailed project plan and timeline for [CUSTOMER_NAME] based on this discovered data:

Data: [DISCOVERED_DATA]

Generate:
1. Project phases and milestones
2. Task breakdown with dependencies
3. Resource allocation by phase
4. Critical path analysis
5. Risk points and contingency planning
6. Approval gates and decision points
7. Reporting and governance structure

Format as structured project plan with Gantt chart visualization.
```

## Business Architecture Diagram Creation

```
Create business architecture diagrams for [CUSTOMER_NAME] showing:

1. How the system connects business needs to technical delivery
2. Value flow from practice kits to customer outcomes
3. Governance and quality assurance mechanisms

Use mermaid syntax for:
- Business architecture overview
- Value flow visualization
- Governance mechanisms
- Executive view
```

## Terraform Module Generation

```
Generate Terraform modules for [CUSTOMER_NAME] with the following requirements:
- AWS Services: [LIST_AWS_SERVICES]
- Environment: [ENVIRONMENT_TYPE]
- Compliance: [COMPLIANCE_REQUIREMENTS]

Create:
1. Main module configuration
2. Variables and outputs
3. Security configurations
4. Tagging strategy
5. Documentation

Follow AWS best practices for:
- Resource naming conventions
- Security group configurations
- IAM least privilege
- Encryption at rest and in transit
```

## GitLab CI/CD Pipeline Configuration

```
Generate GitLab CI/CD pipeline for [CUSTOMER_NAME]:
- Deployment environments: dev, test, prod
- Testing requirements: unit, integration, security
- AWS services: [LIST_SERVICES]

Create:
1. .gitlab-ci.yml configuration
2. Build and test stages
3. Deployment automation
4. Security scanning integration
5. Notification configurations
```

## Practice Kit Customization

```
Customize [PRACTICE_KIT] for [CUSTOMER_NAME]:
- Industry: [INDUSTRY_TYPE]
- Compliance requirements: [COMPLIANCE_STANDARDS]
- Specific use cases: [USE_CASES]

Generate:
1. Industry-specific configurations
2. Compliance control implementations
3. Custom workflows
4. Specialized monitoring
5. Reporting customizations
```

## Audit and Documentation Review

```
Audit all README.md files across all directories and subdirectories in the Cloudelligent project.

🎯 Objectives
Perform a structured audit of implementation tool/function references to ensure they are:
- Clearly referenced (not implied or missing)
- Correctly named and described
- Logically connected to the documented workflows
- Accurately located in the filesystem
- Consistent across practice kits and modules

Generate a comprehensive report with:
1. Executive summary of findings
2. Detailed issues list
3. Recommendations for improvements
4. Implementation priority matrix
```