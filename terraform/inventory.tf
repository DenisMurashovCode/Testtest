resource "local_file" "ansible_inventory" {
  filename        = "${path.module}/../ansible/inventory.ini"
  file_permission = "0644"
  content = templatefile("${path.module}/templates/inventory.tmpl", {
    bastion_ip       = yandex_compute_instance.bastion.network_interface.0.nat_ip_address
    web1_ip          = yandex_compute_instance.web_1.network_interface.0.ip_address
    web2_ip          = yandex_compute_instance.web_2.network_interface.0.ip_address
    prometheus_ip    = yandex_compute_instance.prometheus.network_interface.0.ip_address
    grafana_ip       = yandex_compute_instance.grafana.network_interface.0.ip_address
    elasticsearch_ip = yandex_compute_instance.elasticsearch.network_interface.0.ip_address
    kibana_ip        = yandex_compute_instance.kibana.network_interface.0.ip_address
  })
}
