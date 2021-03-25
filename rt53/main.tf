provider "aws" {
  region = "us-east-1"
   version = "~> 2.20"
}

variable "vpc" {
  default = "vpc-067798a4183535af0"
}

# ---------------------------------------------------------------------------------------------------------------------
# Create the private zone and a-record
# ---------------------------------------------------------------------------------------------------------------------

module "route53" {
  source  = "mineiros-io/route53/aws"

  name = "smoothiemachine.local"

  # Private zones require at least one VPC association at all times.
  vpc_ids = [var.vpc]

  records = [
    {
	  name = "web0.smoothiemachine.local"
      type = "A"
      ttl  = 3600
      records = [
        "34.235.150.179"
      ]
    },
    {
	  name = "web1.smoothiemachine.local"
      type = "A"
      ttl  = 3600
      records = [
        "35.173.226.155"
      ]
    },
    {
      type = "CNAME"
      name = "dh.smoothiemachine.local"
      records = [
        "elb-apache-216879167.us-east-1.elb.amazonaws.com"
      ]
    }	
  ]
}
