resource "aws_ecs_service" "some-service-service" {
  name            = "some-service-service"
  cluster         = aws_ecs_cluster.dev-cluster.id
  task_definition = aws_ecs_task_definition.some-service-task-definition.arn
  launch_type     = "FARGATE"
  desired_count   = 1
  network_configuration {
    subnets          = [
      aws_default_subnet.default_subnet_a.id,
      aws_default_subnet.default_subnet_b.id,
      aws_default_subnet.default_subnet_c.id
    ]
    assign_public_ip = true
  }
}

resource "aws_ecs_task_definition" "some-service-task-definition" {
  family                   = "some-service-task-definition"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "some-service-task",
      "image": "ghcr.io/frellisandbox/some-service:0.0.5",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 8080,
          "hostPort": 8080
        }
      ],
      "memory": 1024,
      "cpu": 512,
      "logConfiguration": {
                  "logDriver": "awslogs",
                  "options": {
                      "awslogs-region" : "eu-west-1",
                      "awslogs-group" : "some-service-logs",
                      "awslogs-stream-prefix" : "project"
                  }
              }
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 1024
  cpu                      = 512
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
