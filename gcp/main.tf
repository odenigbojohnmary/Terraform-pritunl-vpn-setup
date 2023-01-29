/******************************************
	Provider configuration
 *****************************************/
provider "google" {
  # version     = "~> 3.69.0"
  project     = var.project_id
  region      = var.region
  # credentials = file("./key.json")
}

provider "google-beta" {
  # version     = "=> 3.69.0"
  project     = var.project_id
  region      = var.region
  # credentials = file("./key.json")
}

terraform {
  backend "gcs" {
    bucket      = "tfstate_qa_store"
    prefix      = "test/default.tfstate"
    # credentials = "./key.json"
  }
}

locals {
  hostname = format("%s-pritunl-vpn", var.vpn_name)
}

// Dedicated service account for the pritunl_vpn instance.
resource "google_service_account" "pritunl_vpn" {
  account_id   = format("%s-pritunl-vpn-sa", var.vpn_name)
  display_name = "pritunl vpn Service Account"
}

// The user-data script on pritunl_vpn instance provisioning.
data "template_file" "startup_script" {
  template = file("${path.module}./provisioners/ubuntu-20.sh")
  
}

// The pritunl_vpn host.
resource "google_compute_instance" "pritunl-vpn" {
  name         = local.hostname
  machine_type = "e2-micro"
  zone         = var.zone
  project      = var.project_id
  tags         = ["pritunl-vpn"]

# to get different images name you run the command: 
# gcloud compute images list | grep debian
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  // Install printunl vpn on startup.
  metadata_startup_script = data.template_file.startup_script.rendered

  network_interface {
    subnetwork = var.subnet_name

    
    access_config {
      // Not setting "nat_ip", use an ephemeral external IP.
      network_tier = "STANDARD"
    }
  }

  // Allow the instance to be stopped by Terraform when updating configuration.
  allow_stopping_for_update = true

  service_account {
    email  = google_service_account.pritunl_vpn.email
    scopes = ["cloud-platform"]
  }

  /* local-exec providers may run before the host has fully initialized.
  However, they are run sequentially in the order they were defined.
  This provider is used to block the subsequent providers until the instance is available. */
  provisioner "local-exec" {
    command = <<EOF
        READY=""
        for i in $(seq 1 20); do
          if gcloud compute ssh ${local.hostname} --project ${var.project_id} --zone ${var.region}-a --command uptime; then
            READY="yes"
            break;
          fi
          echo "Waiting for ${local.hostname} to initialize..."
          sleep 10;
        done
        if [[ -z $READY ]]; then
          echo "${local.hostname} failed to start in time."
          echo "Please verify that the instance starts and then re-run `terraform apply`"
          exit 1
        fi
EOF
  }

  scheduling {
    preemptible       = true
    automatic_restart = false
  }
}