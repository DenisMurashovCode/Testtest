
resource "yandex_vpc_network" "diplom" {
  name = "diplom-network"
}

resource "yandex_vpc_subnet" "public_a" {
  name           = "public-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

resource "yandex_vpc_subnet" "public_b" {
  name           = "public-ru-central1-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["10.0.2.0/24"]
}

resource "yandex_vpc_gateway" "nat" {
  name = "diplom-nat-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "private" {
  name       = "diplom-private-rt"
  network_id = yandex_vpc_network.diplom.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat.id
  }
}

resource "yandex_vpc_subnet" "private_a" {
  name           = "private-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["10.0.10.0/24"]
  route_table_id = yandex_vpc_route_table.private.id
}

resource "yandex_vpc_subnet" "private_b" {
  name           = "private-ru-central1-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["10.0.20.0/24"]
  route_table_id = yandex_vpc_route_table.private.id
}
