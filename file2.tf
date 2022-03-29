provider "aws" {
  region     = "us-east-1"

}
resource "aws_instance" "terraform_class" {
  ami= "ami-0c02fb55956c7d316 "
  instance_type = "t2.micro"

  tags = {
    Name = "Hello aryan"
  }
}



resource "aws_ebs_volume" "TFebs1" {
 availability_zone = aws_instance.terraform_class.availability_zone
 size = 1

 tags = {
  Name = "Extra_EBS"
 }

}
resource "aws_volume_attachment" "attach_ebs_1" {
device_name = "/dev/sdh"
volume_id = aws_ebs_volume.TFebs1.id
instance_id =aws_instance.terraform_class.id
}
resource "aws_eip" "lb" {
  instance = aws_instance.terraform_class.id
  vpc      = true
}
resource "aws_security_group" "cw_sg_ssh" {
  name = "my private"

  #Incoming traffic
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["103.170.190.43/32"] #replace it with your ip address
  }

  #Outgoing traffic
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
