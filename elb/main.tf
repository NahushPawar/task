provider "aws" {
  region = "us-east-1"
}

## LB ##

module "elb_http" {
  source  = "terraform-aws-modules/elb/aws"
  version = "~> 2.0"

  name = "elb-apache"

  subnets         = ["subnet-04d880c8f0a8cec15", "subnet-00d2fb89e2f8a15e7"]
  security_groups = ["sg-094125cb060d3e3f6"]
  internal        = false

  listener = [
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 80
      lb_protocol       = "HTTP"
    }
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }


  // ELB attachments
  number_of_instances = 2
  instances           = ["i-08d26a8c47e9e96c7", "i-016515b414a6cc35a"]

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}
