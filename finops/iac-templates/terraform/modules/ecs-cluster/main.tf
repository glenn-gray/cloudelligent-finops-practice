# ECS Cluster for OpenOps Platform
# Account: 052236698216, Region: us-east-1

resource "aws_ecs_cluster" "openops" {
  name = "openops-finops-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = var.tags
}

resource "aws_ecs_cluster_capacity_providers" "openops" {
  cluster_name = aws_ecs_cluster.openops.name
  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

# Task Definition
resource "aws_ecs_task_definition" "openops" {
  family                   = "openops-finops"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.ecs_execution.arn
  task_role_arn           = var.openops_task_role_arn

  container_definitions = jsonencode([
    {
      name  = "openops"
      image = "python:3.9-slim"
      
      command = [
        "sh", "-c",
        "echo 'OpenOps container running on port 8080' && python3 -m http.server 8080"
      ]
      
      portMappings = [
        {
          containerPort = 8080
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "AWS_REGION"
          value = var.region
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.openops.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  tags = var.tags
}

# ECS Service
resource "aws_ecs_service" "openops" {
  name            = "openops-finops-service"
  cluster         = aws_ecs_cluster.openops.id
  task_definition = aws_ecs_task_definition.openops.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [aws_security_group.openops_ecs.id]
    assign_public_ip = false
  }

  tags = var.tags
}

# Security Group for ECS
resource "aws_security_group" "openops_ecs" {
  name_prefix = "openops-ecs-"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "openops-ecs-sg"
  })
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "openops" {
  name              = "/ecs/openops-finops"
  retention_in_days = 7
  tags              = var.tags
}

# ECS Execution Role
resource "aws_iam_role" "ecs_execution" {
  name = "openops-ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ecs_execution" {
  role       = aws_iam_role.ecs_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Outputs
output "cluster_name" {
  value = aws_ecs_cluster.openops.name
}

output "service_name" {
  value = aws_ecs_service.openops.name
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.openops.arn
}