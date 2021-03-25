provider "aws" {
  region = "us-east-1"
  
}

variable "ingress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [80]
}

resource "aws_security_group" "nginx" {
  name        = "nginx-sg"
  description = "Ingress for nginx"
  vpc_id      = "vpc-067798a4183535af0"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 }

output "from_ports" {
  value = aws_security_group.nginx.ingress[*].from_port
  
}
