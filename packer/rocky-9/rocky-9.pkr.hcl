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

variable "node" {
    type = string
    default = ""
}

variable "iso_store" {
    type = string
    default = "local:iso"
}

variable "image_file" {
    type = string
    default = "Rocky-9.4-x86_64-dvd.iso"
}

source "proxmox-iso" "rocky9" {
    iso_file = "${var.iso_store}/${var.image_file}"
    iso_checksum = "e20445907daefbfcdb05ba034e9fc4cf91e0e8dc164ebd7266ffb8fdd8ea99e"
    unmount_iso = true

    proxmox_url = "${local.pve_api_url}"
    username = "${local.pve_api_token_id}"
    token = "${local.pve_api_token_secret}"
    insecure_skip_tls_verify = true

    node = var.node
    task_timeout = "5m"

    vm_name = "rocky9-cloudinit"

    memory = 8192
    cpu_type = "host"
    cores = 2

    network_adapters {
        bridge = "vmbr1"
        model = "virtio"
        firewall = false
    }

    disks {
        type = "scsi"
        disk_size = "32G"
        storage_pool = "local-zfs"
    }
    scsi_controller = "virtio-scsi-single"

    qemu_agent = true

    cloud_init = true
    cloud_init_storage_pool = "local-zfs"

    http_directory = "${path.root}http"

    boot_wait = "10s"
    boot_command = [
       "<up><wait><tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/inst.ks<enter><wait>" 
    ]

    ssh_username = "root"
    ssh_password = "Packer"
    ssh_timeout = "30m"
    
}

build {
    name = "rocky9-proxmox"

    sources = [ "source.proxmox-iso.rocky9" ]

    provisioner "file" {
        source = "${path.root}/cloud.cfg"
        destination = "/tmp/cloud.cfg"
    }

    provisioner "shell" {
        inline = [ "cp /tmp/cloud.cfg /etc/cloud/cloud.cfg.d/ansible.cfg" ]
    }

    provisioner "shell" {
        inline = [
           "systemctl enable qemu-guest-agent",
           "shred -u /etc/ssh/*_key /etc/ssh/*_key.pub",
           "rm -f /var/run/utmp",
           ">/var/log/lastlog",
           ">/var/log/wtmp",
           ">/var/log/btmp",
           "rm -rf /tmp/* /var/tmp/*",
           "unset HISTFILE; rm -rf /home/*/.*history /root/.*history",
           "rm -f /root/*ks",
           "passwd -d root",
           "passwd -l root",
           "sed -e 's/PermitRootLogin yes/#PermitRootLogin prohibit-password/' -i /etc/ssh/sshd_config"
        ]
    }
}
