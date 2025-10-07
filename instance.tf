resource "aws_instance" "jenkins" {
  ami                    = data.aws_ssm_parameter.al2.value
  instance_type          = "t2.medium"
  key_name               = aws_key_pair.capstone_key.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  root_block_device {
    volume_size = 30  # GB
    volume_type = "gp3"
  }

  user_data = file("${path.module}/bootstrap.sh")

  tags = { Name = "jenkins-server" }
}

