module "this" {
  source      = "./modules/terraform-module-null-label"
  namespace   = var.namespace
  name        = var.name
  stage       = var.stage
  environment = var.environment
  delimiter   = var.delimiter
  attributes  = var.attributes
  tags        = var.tags
  enabled     = var.enabled
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_ami" "ubuntu" {
  most_recent = true

# add the ubuntu 20 image you want to use from AWS ami here
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20230112"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# create the pritunl EC2 instance for the pritunl
resource "aws_instance" "pritunl" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.aws_key_name
  user_data     = file("provision.sh")

  vpc_security_group_ids = [
    aws_security_group.pritunl.id,
    aws_security_group.allow_from_office.id,
  ]

  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = false
  tags        = module.this.tags

}

# create an elastic ip and assign it to the instance
resource "aws_eip" "pritunl" {
  instance = "${aws_instance.pritunl.id}"
  vpc      = true
}