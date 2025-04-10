resource "yandex_vpc_security_group" "bastion_sg" {
  name        = "bastion-sg"
  network_id  = yandex_vpc_network.vpc.id
  description = "Security group for bastion"

  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]  
    description    = "Allow SSH from anywhere"
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "web_sg" {
  name        = "web-sg"
  network_id  = yandex_vpc_network.vpc.id
  description = "Security group for web servers"

  # SSH (22) только из подсети 10.128.0.0/24, где находится bastion
  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["10.128.0.0/24"]
    description    = "Allow SSH from subnet-a"
  }

  # HTTP (80) откуда угодно (если нужно тестировать извне):
  ingress {
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
    description    = "Allow HTTP from anywhere"
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
