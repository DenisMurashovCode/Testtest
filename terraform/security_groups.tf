resource "yandex_vpc_security_group" "bastion" {
  name       = "sg-bastion"
  network_id = yandex_vpc_network.diplom.id

  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "web" {
  name       = "sg-web"
  network_id = yandex_vpc_network.diplom.id

  ingress {
    protocol          = "TCP"
    port              = 22
    security_group_id = yandex_vpc_security_group.bastion.id
  }

  ingress {
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol          = "TCP"
    port              = 9100
    security_group_id = yandex_vpc_security_group.prometheus.id
  }

  ingress {
    protocol          = "TCP"
    port              = 9113
    security_group_id = yandex_vpc_security_group.prometheus.id
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "prometheus" {
  name       = "sg-prometheus"
  network_id = yandex_vpc_network.diplom.id

  ingress {
    protocol          = "TCP"
    port              = 22
    security_group_id = yandex_vpc_security_group.bastion.id
  }

  ingress {
    protocol          = "TCP"
    port              = 9090
    security_group_id = yandex_vpc_security_group.grafana.id
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "grafana" {
  name       = "sg-grafana"
  network_id = yandex_vpc_network.diplom.id

  ingress {
    protocol          = "TCP"
    port              = 22
    security_group_id = yandex_vpc_security_group.bastion.id
  }

  ingress {
    protocol       = "TCP"
    port           = 3000
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "elasticsearch" {
  name       = "sg-elasticsearch"
  network_id = yandex_vpc_network.diplom.id

  ingress {
    protocol          = "TCP"
    port              = 22
    security_group_id = yandex_vpc_security_group.bastion.id
  }

  ingress {
    protocol          = "TCP"
    port              = 9200
    security_group_id = yandex_vpc_security_group.kibana.id
  }

  ingress {
    protocol          = "TCP"
    port              = 9200
    security_group_id = yandex_vpc_security_group.web.id
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "kibana" {
  name       = "sg-kibana"
  network_id = yandex_vpc_network.diplom.id

  ingress {
    protocol          = "TCP"
    port              = 22
    security_group_id = yandex_vpc_security_group.bastion.id
  }

  ingress {
    protocol       = "TCP"
    port           = 5601
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "balancer" {
  name       = "sg-balancer"
  network_id = yandex_vpc_network.diplom.id

  ingress {
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    port           = 30080
    v4_cidr_blocks = ["198.18.235.0/24", "198.18.248.0/24"]
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
