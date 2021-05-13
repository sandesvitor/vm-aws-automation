data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public" {
  count                   = length(data.aws_availability_zones.available.names)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.main_network_block, var.subnet_prefix_extension, tonumber(substr(data.aws_availability_zones.available.zone_ids[count.index], length(data.aws_availability_zones.available.zone_ids[count.index]) - 1, 1)) - 1)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.subnet_name_tag}/${data.aws_availability_zones.available.names[count.index]}"
  }
}