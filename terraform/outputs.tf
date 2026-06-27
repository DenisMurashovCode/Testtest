output "network_id" {
  value = yandex_vpc_network.diplom.id
}

output "subnet_public_a" { value = yandex_vpc_subnet.public_a.id }
output "subnet_public_b" { value = yandex_vpc_subnet.public_b.id }
output "subnet_private_a" { value = yandex_vpc_subnet.private_a.id }
output "subnet_private_b" { value = yandex_vpc_subnet.private_b.id }

output "bastion_public_ip" {
  value = yandex_compute_instance.bastion.network_interface.0.nat_ip_address
}
output "grafana_public_ip" {
  value = yandex_compute_instance.grafana.network_interface.0.nat_ip_address
}
output "kibana_public_ip" {
  value = yandex_compute_instance.kibana.network_interface.0.nat_ip_address
}

output "web1_private_ip" {
  value = yandex_compute_instance.web_1.network_interface.0.ip_address
}
output "web2_private_ip" {
  value = yandex_compute_instance.web_2.network_interface.0.ip_address
}
output "prometheus_private_ip" {
  value = yandex_compute_instance.prometheus.network_interface.0.ip_address
}
output "elasticsearch_private_ip" {
  value = yandex_compute_instance.elasticsearch.network_interface.0.ip_address
}
output "balancer_public_ip" {
  value = yandex_alb_load_balancer.web.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
}
