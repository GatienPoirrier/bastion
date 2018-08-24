resource "aws_security_group" "bastion_connexion" {
  vpc_id = "${aws_vpc.main.id}"
  name        = "bastion_connexion"
  description = "bastion_connexion"

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port       = 0
      to_port         = 65535
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
    }


tags {
    Name = "bastion_connexion"
  }
}

resource "aws_security_group" "private_connexion" {
  vpc_id = "${aws_vpc.main.id}"
  name        = "private_connexion"
  description = "private_connexion with bastion only"

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      security_groups = ["${aws_security_group.bastion_connexion.id}"]
  }
  egress {
      from_port       = 0
      to_port         = 65535
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
    }
tags {
    Name = "private_connexion"
  }
}
