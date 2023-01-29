// Allow access to the pritunl_vpn Host via SSH.
resource "google_compute_firewall" "pritunl-vpn-ssh" {
  name          = format("%s-pritunl-vpn-ssh", var.vpn_name)
  network       = var.network_name
  direction     = "INGRESS"
  project       = var.project_id
  source_ranges = ["0.0.0.0/0"] // TODO: Restrict further.

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  target_tags = ["pritunl-vpn"]
}