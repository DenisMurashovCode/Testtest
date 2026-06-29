resource "yandex_compute_snapshot_schedule" "daily" {
  name = "diplom-daily-week"

  schedule_policy {
    expression = "0 2 * * *"   # каждый день в 02:00 UTC
  }

  retention_period = "168h"    # TTL снапшота — 7 дней (7*24=168ч)

  snapshot_spec {
    description = "Daily snapshot of diploma VM disks, 7-day TTL"
  }

  disk_ids = [
    yandex_compute_instance.bastion.boot_disk.0.disk_id,
    yandex_compute_instance.web_1.boot_disk.0.disk_id,
    yandex_compute_instance.web_2.boot_disk.0.disk_id,
    yandex_compute_instance.prometheus.boot_disk.0.disk_id,
    yandex_compute_instance.grafana.boot_disk.0.disk_id,
    yandex_compute_instance.elasticsearch.boot_disk.0.disk_id,
    yandex_compute_instance.kibana.boot_disk.0.disk_id,
  ]
}

output "snapshot_schedule_id" {
  value = yandex_compute_snapshot_schedule.daily.id
}
