data "aws_ssm_parameter" "ubuntu1804" {
  name = "/aws/service/canonical/ubuntu/server/18.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}
resource "aws_instance" "technical_test_ariane" {
  ami           = data.aws_ssm_parameter.ubuntu1804.value
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.ariane_sg.id]
  tags = {"Name" ="${var.default_tags.project}-ariane"}
}

resource "aws_instance" "technical_test_falcon" {
  ami           = data.aws_ssm_parameter.ubuntu1804.value
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet.id
  security_groups = [aws_security_group.falcon_sg.id]
  tags = {"Name" ="${var.default_tags.project}-falcon"}
}

resource "aws_instance" "technical_test_redis" {
  ami           = data.aws_ssm_parameter.ubuntu1804.value
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet.id
  security_groups = [aws_security_group.redis_sg.id]
  tags = {"Name" ="${var.default_tags.project}-redis"}
}
