resource "aws_instance" "instance" {
    ami                    = data.aws_ami.ami.id
    instance_type          = var.instance_type
    vpc_security_group_ids = var.security_groups
    subnet_id              = var.subnet_id
    key_name               = var.key_name
    iam_instance_profile   = var.instance_profile

    associate_public_ip_address = true

    lifecycle {
        prevent_destroy = false
        ignore_changes = [
            ami,
            subnet_id,
        ]
    }

    root_block_device {
        volume_type           = "gp2"
        volume_size           = var.volume_size
        delete_on_termination = true
    }

    volume_tags = {
        Name    = var.volume_name
    }

    tags = {
        Name = var.instance_name
        Service = var.service
    }

    provisioner "remote-exec" {
        inline = ["echo 'I am available'"]

        connection {
            type = "ssh"
            user = "ubuntu"
            host = self.public_ip
            private_key = file(var.key_pair_path)
        }
    }
}

resource "aws_route53_record" "instance_private_domain" {
  zone_id = var.route53_zone_id
  name    = aws_instance.instance.tags.Name
  type    = "A"
  ttl     = "60"
  records = [aws_instance.instance.private_ip]
}