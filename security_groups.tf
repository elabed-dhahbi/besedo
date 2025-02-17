resource "aws_security_group" "ariane_sg" {

  vpc_id = aws_vpc.technical_test_vpc.id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["82.11.22.33/32", "81.44.55.87/32", "87.12.33.88/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "falcon_sg" {
  vpc_id = aws_vpc.technical_test_vpc.id
  ingress {
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    security_groups = [aws_security_group.ariane_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redis_sg" {
  vpc_id = aws_vpc.technical_test_vpc.id
  ingress {
    from_port   = 6399
    to_port     = 6399
    protocol    = "tcp"
    security_groups = [aws_security_group.falcon_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
