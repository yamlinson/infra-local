// Variables
local "pve_api_url" {
    expression = vault("/kv/data/proxmox", "pve_api_url")
    sensitive = true
}

local "pve_api_token_id" {
    expression = vault("/kv/data/proxmox", "pve_api_token_id")
    sensitive = true
}

local "pve_api_token_secret" {
    expression = vault("/kv/data/proxmox", "pve_api_token_secret")
    sensitive = true
}

// Resource definition
source "proxmox" "ubuntu-server-jammy-tholus" {

    // Connection Settings
    proxmox_url = "${local.pve_api_url}"
    username = "${local.pve_api_token_id}"
    token = "${local.pve_api_token_secret}"
    insecure_skip_tls_verify = true

    // VM Settings
    node = "tholus"
    vm_id = "8100"
    vm_name = "ubuntu-server-jammy-tholus"

    iso_file = "local:iso/ubuntu-22.04.2-live-server-amd64.iso"
    unmount_iso = true

    qemu_agent = true

    scsi_controller = "virtio-scsi-pci"

    disks {
        type = "scsi"
        disk_size = "32G"
        storage_pool = "local-lvm"
        storage_pool_type = "lvm"
    }

    cores = "2"
    memory = "4096"

    network_adapters {
        model = "virtio"
        bridge = "vmbr1"
        firewall = "false"
    }

    cloud_init = true
    cloud_init_storage_pool = "local-lvm"

    // Packer Autoinstall
    boot_command = [
        "<esc><wait>",
        "e<wait>",
        "<down><down><down><end>",
        "<bs><bs><bs><bs><wait>",
        "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
        "<f10><wait>"
    ]
    boot = "c"
    boot_wait = "5s"

    http_directory = "http"

    ssh_username = "ansible"
    ssh_private_key_file = "~/.ssh/ansible_rsa"
    ssh_timeout = "20m"

}

// Build definition
build {

    name = "ubuntu-server-jammy-tholus"
    sources = ["source.proxmox.ubuntu-server-jammy-tholus"]

    provisioner "shell" {
        inline = [
            "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
            "sudo rm /etc/ssh/ssh_host_*",
            "sudo truncate -s 0 /etc/machine-id",
            "sudo apt -y autoremove --purge",
            "sudo apt -y clean",
            "sudo apt -y autoclean",
            "sudo cloud-init clean",
            "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
            "sudo rm -f /etc/netplan/00-installer-config.yaml",
            "sudo sync"
        ]
    }

    provisioner "file" {
        source = "files/99-pve.cfg"
        destination = "/tmp/99-pve.cfg"
    }

    provisioner "shell" {
        inline = [ "sudo cp /tmp/99-pve.cfg /etc/cloud/cloud.cfg.d/99-pve.cfg" ]
    }

}