resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = var.internet_gateway_name_tag
  }
}