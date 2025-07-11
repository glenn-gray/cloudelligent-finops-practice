# ECS Cluster for OpenOps Platform

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

resource "aws_ecs_task_definition" "openops" {
  family                   = "openops-finops"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.ecs_execution.arn
  task_role_arn            = var.openops_task_role_arn

  container_definitions = jsonencode([
    {
      name  = "openops"
      image = "amazonlinux:2"
      command = [
        "sh", "-c",
        <<-EOF
        # Install dependencies
        yum update -y
        yum install -y python3 curl unzip amazon-ssm-agent git
        
        # Install AWS CLI
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        ./aws/install
        
        # Start SSM Agent
        systemctl start amazon-ssm-agent
        
        # Clone GitHub repo for policies and scripts
        cd /opt
        git clone https://github.com/glenn-gray/cloudelligent-customer-implementations.git
        
        # Set up OpenOps directory structure
        mkdir -p /opt/openops/{policies,test-scripts}
        
        # Copy policies and scripts from repo
        cp /opt/cloudelligent-customer-implementations/Cloudelligent-Production-infra/finops/iac-templates/openops/policies/* /opt/openops/policies/ 2>/dev/null || echo "No policies found in repo"
        cp /opt/cloudelligent-customer-implementations/Cloudelligent-Production-infra/finops/iac-templates/openops/test-scripts/* /opt/openops/test-scripts/ 2>/dev/null || echo "No test scripts found in repo"
        chmod +x /opt/openops/test-scripts/*.sh 2>/dev/null || echo "No shell scripts to make executable"
        
        # Create OpenOps server
        cat > /opt/openops/server.py << 'PYTHON'
import http.server
import socketserver
import json
import os
from urllib.parse import urlparse

class OpenOpsHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/api/status':
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            response = {"status": "healthy", "version": "1.0.0", "platform": "ECS"}
            self.wfile.write(json.dumps(response).encode())
        elif self.path == '/health':
            self.send_response(200)
            self.send_header('Content-type', 'text/plain')
            self.end_headers()
            self.wfile.write(b'OK')
        elif self.path.startswith('/policies'):
            if self.path == '/policies/' or self.path == '/policies':
                # List available policies
                policy_files = [f for f in os.listdir('/opt/openops/policies') if f.endswith('.json')]
                self.send_response(200)
                self.send_header('Content-type', 'application/json')
                self.end_headers()
                response = {"policies": policy_files}
                self.wfile.write(json.dumps(response).encode())
            else:
                # Serve specific policy file
                policy_name = self.path.split('/')[-1]
                policy_path = f'/opt/openops/policies/{policy_name}'
                if os.path.exists(policy_path):
                    with open(policy_path, 'r') as f:
                        self.send_response(200)
                        self.send_header('Content-type', 'application/json')
                        self.end_headers()
                        self.wfile.write(f.read().encode())
                else:
                    self.send_response(404)
                    self.end_headers()
        else:
            super().do_GET()

with socketserver.TCPServer(("", 8080), OpenOpsHandler) as httpd:
    print("OpenOps ECS service running on port 8080")
    print("Available policies:", os.listdir('/opt/openops/policies'))
    print("Available test scripts:", os.listdir('/opt/openops/test-scripts'))
    httpd.serve_forever()
PYTHON
        
        # Start OpenOps service
        cd /opt/openops
        python3 server.py
        EOF
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
      linuxParameters = {
        initProcessEnabled = true
      }
    }
  ])

  tags = var.tags
}

resource "aws_ecs_service" "openops" {
  name            = "openops-finops-service"
  cluster         = aws_ecs_cluster.openops.id
  task_definition = aws_ecs_task_definition.openops.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  enable_execute_command = true

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.openops_ecs_sg_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.openops_tg.arn
    container_name   = "openops"
    container_port   = 8080
  }

  depends_on = [aws_lb_listener.openops_listener]

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "openops" {
  name              = "/ecs/openops-finops"
  retention_in_days = 7
  tags              = var.tags
}

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

resource "aws_iam_role_policy_attachment" "ecs_exec" {
  role       = aws_iam_role.ecs_execution.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_lb" "openops_alb" {
  name               = "openops-finops-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.openops_ecs_sg_id]
  subnets            = var.private_subnet_ids
  tags               = var.tags
}

resource "aws_lb_target_group" "openops_tg" {
  name     = "openops-finops-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = var.tags
}

resource "aws_lb_listener" "openops_listener" {
  load_balancer_arn = aws_lb.openops_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.openops_tg.arn
  }
}

output "cluster_name" {
  value = aws_ecs_cluster.openops.name
}

output "service_name" {
  value = aws_ecs_service.openops.name
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.openops.arn
}

output "alb_dns_name" {
  value = aws_lb.openops_alb.dns_name
}