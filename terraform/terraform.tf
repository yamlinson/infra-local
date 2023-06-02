terraform {

    required_version = ">= 1.4.0"

    required_providers {
        vault = {
            source = "hashicorp/vault"
            version = "3.15.2"
        }
        proxmox = {
            source = "telmate/proxmox"
            version = "2.9.11"
        }
    }
}
