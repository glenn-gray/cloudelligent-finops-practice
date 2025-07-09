# Extension Points Automation Prompts

This document contains AI prompts for automating infrastructure, documentation, CI/CD, and integration customizations across Cloudelligent practice kits.

---
## Documentation Automation & Avoma Transcript Analysis 

### Architecture Documentation from Discovery

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

Output path: /Users/gg/projects/cloudelligent/customer-implementations/[CUSTOMER_NAME]-infra/[PRACTICE]/docs/architecture/[PRACTICE]-architecture.drawio.md
```

### Implementation Guide from Requirements

```
Create implementation guide based on Avoma transcript for [CUSTOMER_NAME]:

Transcript: [PASTE_AVOMA_TRANSCRIPT]

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

Output path: /Users/gg/projects/cloudelligent/customer-implementations/[CUSTOMER_NAME]-infra/[PRACTICE]/docs/implementation-guide.md
```

### Executive Summary for Stakeholders

```
Generate an executive summary for [CUSTOMER_NAME] stakeholders based on this Avoma transcript:

Transcript: [PASTE_AVOMA_TRANSCRIPT]

Include:
1. Project overview and business value
2. Key modernization benefits
3. High-level approach and timeline
4. Resource and investment summary
5. Critical success factors
6. Risk management strategy
7. Next steps and recommendations

Format for C-level executives with focus on business outcomes and ROI.

Output path: /Users/gg/projects/cloudelligent/customer-implementations/[CUSTOMER_NAME]-infra/[PRACTICE]/sow-components/executive-summary.md
```

### Project Plan and Timeline

```
Create detailed project plan and timeline for [CUSTOMER_NAME] based on Avoma transcript:

Transcript: [PASTE_AVOMA_TRANSCRIPT]

Generate:
1. Project phases and milestones
2. Task breakdown with dependencies
3. Resource allocation by phase
4. Critical path analysis
5. Risk points and contingency planning
6. Approval gates and decision points
7. Reporting and governance structure

Format as structured project plan with Gantt chart visualization.

Output path: /Users/gg/projects/cloudelligent/customer-implementations/[CUSTOMER_NAME]-infra/[PRACTICE]/delivery-blueprint/project-plan.md
```
---
## Infrastructure Template Extensions

### Terraform Module Generation
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

### Terraform Module Update
```
Extend existing Terraform infrastructure for [CUSTOMER_NAME]:
- Base infrastructure: [EXISTING_MODULES]
- New requirements: [ADDITIONAL_REQUIREMENTS]
- Integration points: [INTEGRATION_DETAILS]

Generate:
1. Additional Terraform modules
2. Updated variable definitions
3. Module integration code
4. Dependency management
5. State management strategy
```

## CI/CD Pipeline Automation

### Pipeline Configuration
```
Generate CI/CD pipeline for [CUSTOMER_NAME]:
- CI/CD Tool: [GITLAB_CI/GITHUB_ACTIONS/JENKINS]
- Deployment environments: [ENVIRONMENTS]
- Testing requirements: [TEST_STRATEGY]

Create:
1. Pipeline configuration files
2. Build and test stages
3. Deployment automation
4. Security scanning integration
5. Notification configurations
```

### GitOps Configuration
```
Create GitOps configuration for [CUSTOMER_NAME]:
- GitOps Tool: [FLUX/ARGOCD]
- Repository structure: [REPO_STRUCTURE]
- Deployment strategy: [DEPLOYMENT_APPROACH]

Generate:
1. GitOps application definitions
2. Repository structure
3. Sync policies
4. Secret management
5. Monitoring configuration
```

## Integration Automation

### AWS Service Integration
```
Generate AWS service integrations for [CUSTOMER_NAME]:
- Primary services: [CORE_SERVICES]
- Integration services: [INTEGRATION_SERVICES]
- Data flow: [DATA_FLOW_REQUIREMENTS]

Create:
1. Service integration code
2. IAM roles and policies
3. Network configurations
4. Monitoring and logging
5. Error handling
```

### Third-Party Integrations
```
Create third-party service integration for [CUSTOMER_NAME]:
- External services: [EXTERNAL_SERVICES]
- Integration patterns: [INTEGRATION_PATTERNS]
- Security requirements: [SECURITY_CONTROLS]

Generate:
1. Integration architecture
2. API configurations
3. Authentication setup
4. Data transformation
5. Error handling and retry logic
```

## Customization Automation

### Customer-Specific Customizations
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

### Environment-Specific Configurations
```
Create environment-specific configurations for [CUSTOMER_NAME]:
- Environments: [ENVIRONMENT_LIST]
- Configuration differences: [CONFIG_VARIATIONS]
- Promotion strategy: [PROMOTION_APPROACH]

Generate:
1. Environment-specific variables
2. Configuration templates
3. Promotion workflows
4. Environment validation
5. Rollback procedures
```