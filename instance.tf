
### BASTION ###
resource "aws_instance" "public" {
  ami           = "ami-04681a1dbd79675a5"
  instance_type = "t2.micro"

  vpc_security_group_ids = ["${aws_security_group.bastion_connexion.id}"]

  subnet_id = "${aws_subnet.public.id}"

  associate_public_ip_address = "true"

  key_name = "MyGuruKP"

  user_data = "${data.template_file.userdata1.rendered}"

  tags {
    Name = "Bastion"
  }
}

### PRIVATE INSTANCE ###
resource "aws_instance" "private" {
  ami           = "ami-04681a1dbd79675a5"
  instance_type = "t2.micro"

  vpc_security_group_ids = ["${aws_security_group.private_connexion.id}"]

  subnet_id = "${aws_subnet.private.id}"

  associate_public_ip_address = "false"

  key_name = "MyGuruKP"


  tags {
    Name = "Private Instance"
  }
}

output "ip" {
  value = "${aws_instance.public.public_ip}"
}

data "template_file" "userdata1" {
  template = "${file("shell/command.sh")}"
}