output "ip" {
  value       = google_compute_instance.pritunl-vpn.network_interface.0.network_ip
  description = "The IP address of the pritunl_vpn instance."
}

output "ssh" {
  description = "GCloud ssh command to connect to the pritunl_vpn instance."
  value       = "gcloud compute ssh ${google_compute_instance.pritunl-vpn.name} --project ${var.project_id} --zone ${google_compute_instance.pritunl-vpn.zone}"
}
