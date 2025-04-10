resource "yandex_vpc_network" "vpc" {
  name = "demo-network"
}

resource "yandex_vpc_subnet" "subnet_a" {
  name           = "subnet-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = ["10.128.0.0/24"]
}

resource "yandex_vpc_subnet" "subnet_b" {
  name           = "subnet-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = ["10.129.0.0/24"]
}

resource "yandex_vpc_gateway" "nat" {
  name      = "demo-nat-gateway"
  network_id = yandex_vpc_network.vpc.id
}

resource "yandex_vpc_route_table" "route-table" {
  name       = "default-route-table"
  network_id = yandex_vpc_network.vpc.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat.id
  }
}

resource "yandex_vpc_subnet_route_table_attachment" "subnet_a_attachment" {
  subnet_id      = yandex_vpc_subnet.subnet_a.id
  route_table_id = yandex_vpc_route_table.route-table.id
}

resource "yandex_vpc_subnet_route_table_attachment" "subnet_b_attachment" {
  subnet_id      = yandex_vpc_subnet.subnet_b.id
  route_table_id = yandex_vpc_route_table.route-table.id
}

resource "yandex_compute_instance" "bastion" {
  name        = "bastion"
  platform_id = "standard-v2"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8pfd17g205ujpmpb0a" # ID образа Ubuntu
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_a.id
    nat       = true  # Чтобы получить внешний IP для bastion
    security_group_ids = [
      yandex_vpc_security_group.bastion_sg.id
    ]
  }

  # Нужно прописать SSH ключ
  metadata = {
    ssh-keys = "ubuntu:${file(/home/tds/.ssh/id_rsa.pub/id_rsa)}"
  }
}

resource "yandex_compute_instance" "web_a" {
  name        = "web-a"
  platform_id = "standard-v2"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8pfd17g205ujpmpb0a"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_a.id
    nat       = false
    security_group_ids = [
      yandex_vpc_security_group.web_sg.id
    ]
  }

  metadata = {
    ssh-keys = "ubuntu:${file(/home/tds/.ssh/id_rsa.pub/id_rsa)}"
  }
}

resource "yandex_compute_instance" "web_b" {
  name        = "web-b"
  platform_id = "standard-v2"
  zone        = "ru-central1-b"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "d8pfd17g205ujpmpb0a"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_b.id
    nat       = false
    security_group_ids = [
      yandex_vpc_security_group.web_sg.id
    ]
  }

  metadata = {
    ssh-keys = "ubuntu:${file(/home/tds/.ssh/id_rsa.pub/id_rsa)}"
  }
}
