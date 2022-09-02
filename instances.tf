data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "webserver1" {
    ami = nonsensitive(data.aws_ssm_parameter.ami.value)
    instance_type = var.instance_type
    subnet_id = aws_subnet.subnet1.id
    vpc_security_group_ids = [aws_security_group.web-sg.id]
    key_name = "jenkins"
    tags = local.common_tags
}

resource "aws_instance" "webserver2" {
    ami = nonsensitive(data.aws_ssm_parameter.ami.value)
    instance_type = var.instance_type
    subnet_id = aws_subnet.subnet2.id
    vpc_security_group_ids = [aws_security_group.web-sg.id]
    key_name = "jenkins"
    tags = local.common_tags
}

resource "aws_instance" "Ansible-control-node" {
    ami = nonsensitive(data.aws_ssm_parameter.ami.value)
    instance_type = var.instance_type
    subnet_id = aws_subnet.subnet1.id
    vpc_security_group_ids = [aws_security_group.web-sg.id]
    key_name = "jenkins"
    tags = local.common_tags
}
