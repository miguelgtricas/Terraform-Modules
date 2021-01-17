data "aws_availability_zones" "zones_available" {
  state = "available"
}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/${var.ami_name}-amd64-server-*", var.ami_name]
    #values = ["ubuntu/images/hvm-ssd/${var.ami_name}-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # Canonical + our account
  owners = ["099720109477", "555230953800"]
}
