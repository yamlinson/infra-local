# Retrieve secrets
data "vault_generic_secret" "ciuser" {
    path = "kv/ansible"
}

# Node01 Controllers
resource "proxmox_vm_qemu" "k3s-n01-8g-c01" {
    name = "k3s-n01-8g-c01"
    target_node = "tholus"
    clone = "ubuntu-server-jammy-tholus"

    onboot = true
    agent = 1
    qemu_os = "other"

    memory = 8192
    balloon = 4096
    sockets = 2
    cores = 2

    boot = "order=scsi0"

    scsihw = "virtio-scsi-pci"
    
    network {
        model = "virtio"
        bridge = "vmbr1"
    }

    disk {
        type = "scsi"
        size = "1024G"
        storage = "local-lvm"
    }

    ssh_user = data.vault_generic_secret.ciuser.data["username"]
    ssh_private_key = data.vault_generic_secret.ciuser.data["ssh_priv"]

    os_type = "cloud-init"
    ipconfig0 = "ip=dhcp"

    ciuser = data.vault_generic_secret.ciuser.data["username"]
    cipassword = data.vault_generic_secret.ciuser.data["password"]
    sshkeys = data.vault_generic_secret.ciuser.data["ssh_pub"]

}

# Node01 Workers
resource "proxmox_vm_qemu" "k3s-n01-16g-w01" {
    name = "k3s-n01-16g-w01"
    target_node = "tholus"
    clone = "ubuntu-server-jammy-tholus"

    onboot = true
    agent = 1
    qemu_os = "other"

    memory = 16384
    balloon = 8192
    sockets = 2
    cores = 3

    boot = "order=scsi0"

    scsihw = "virtio-scsi-pci"
    
    network {
        model = "virtio"
        bridge = "vmbr1"
    }

    disk {
        type = "scsi"
        size = "1024G"
        storage = "local-lvm"
    }

    ssh_user = data.vault_generic_secret.ciuser.data["username"]
    ssh_private_key = data.vault_generic_secret.ciuser.data["ssh_priv"]

    os_type = "cloud-init"
    ipconfig0 = "ip=dhcp"

    ciuser = data.vault_generic_secret.ciuser.data["username"]
    cipassword = data.vault_generic_secret.ciuser.data["password"]
    sshkeys = data.vault_generic_secret.ciuser.data["ssh_pub"]

}

resource "proxmox_vm_qemu" "k3s-n01-16g-w02" {
    name = "k3s-n01-16g-w02"
    target_node = "tholus"
    clone = "ubuntu-server-jammy-tholus"

    onboot = true
    agent = 1
    qemu_os = "other"

    memory = 16384
    balloon = 8192
    sockets = 2
    cores = 3

    boot = "order=scsi0"

    scsihw = "virtio-scsi-pci"
    
    network {
        model = "virtio"
        bridge = "vmbr1"
    }

    disk {
        type = "scsi"
        size = "1024G"
        storage = "local-lvm"
    }

    ssh_user = data.vault_generic_secret.ciuser.data["username"]
    ssh_private_key = data.vault_generic_secret.ciuser.data["ssh_priv"]

    os_type = "cloud-init"
    ipconfig0 = "ip=dhcp"

    ciuser = data.vault_generic_secret.ciuser.data["username"]
    cipassword = data.vault_generic_secret.ciuser.data["password"]
    sshkeys = data.vault_generic_secret.ciuser.data["ssh_pub"]

}

resource "proxmox_vm_qemu" "k3s-n01-8g-w01" {
    name = "k3s-n01-8g-w01"
    target_node = "tholus"
    clone = "ubuntu-server-jammy-tholus"

    onboot = true
    agent = 1
    qemu_os = "other"

    memory = 8192
    balloon = 4096
    sockets = 2
    cores = 2

    boot = "order=scsi0"

    scsihw = "virtio-scsi-pci"
    
    network {
        model = "virtio"
        bridge = "vmbr1"
    }

    disk {
        type = "scsi"
        size = "1024G"
        storage = "local-lvm"
    }

    ssh_user = data.vault_generic_secret.ciuser.data["username"]
    ssh_private_key = data.vault_generic_secret.ciuser.data["ssh_priv"]

    os_type = "cloud-init"
    ipconfig0 = "ip=dhcp"

    ciuser = data.vault_generic_secret.ciuser.data["username"]
    cipassword = data.vault_generic_secret.ciuser.data["password"]
    sshkeys = data.vault_generic_secret.ciuser.data["ssh_pub"]

}

# Node02 Controllers
resource "proxmox_vm_qemu" "k3s-n02-8g-c01" {
    name = "k3s-n02-8g-c01"
    target_node = "watershed"
    clone = "ubuntu-server-jammy-watershed"

    onboot = true
    agent = 1
    qemu_os = "other"

    memory = 8192
    balloon = 4096
    sockets = 2
    cores = 2

    boot = "order=scsi0"

    scsihw = "virtio-scsi-pci"
    
    network {
        model = "virtio"
        bridge = "vmbr1"
    }

    disk {
        type = "scsi"
        size = "256G"
        storage = "pool01"
    }

    ssh_user = data.vault_generic_secret.ciuser.data["username"]
    ssh_private_key = data.vault_generic_secret.ciuser.data["ssh_priv"]

    os_type = "cloud-init"
    ipconfig0 = "ip=dhcp"

    ciuser = data.vault_generic_secret.ciuser.data["username"]
    cipassword = data.vault_generic_secret.ciuser.data["password"]
    sshkeys = data.vault_generic_secret.ciuser.data["ssh_pub"]

}

resource "proxmox_vm_qemu" "k3s-n02-8g-c02" {
    name = "k3s-n02-8g-c02"
    target_node = "watershed"
    clone = "ubuntu-server-jammy-watershed"

    onboot = true
    agent = 1
    qemu_os = "other"

    memory = 8192
    balloon = 4096
    sockets = 2
    cores = 2

    boot = "order=scsi0"

    scsihw = "virtio-scsi-pci"
    
    network {
        model = "virtio"
        bridge = "vmbr1"
    }

    disk {
        type = "scsi"
        size = "256G"
        storage = "pool01"
    }

    ssh_user = data.vault_generic_secret.ciuser.data["username"]
    ssh_private_key = data.vault_generic_secret.ciuser.data["ssh_priv"]

    os_type = "cloud-init"
    ipconfig0 = "ip=dhcp"

    ciuser = data.vault_generic_secret.ciuser.data["username"]
    cipassword = data.vault_generic_secret.ciuser.data["password"]
    sshkeys = data.vault_generic_secret.ciuser.data["ssh_pub"]

}

# Node02 Workers
resource "proxmox_vm_qemu" "k3s-n02-32g-w01" {
    name = "k3s-n02-32g-w01"
    target_node = "watershed"
    clone = "ubuntu-server-jammy-watershed"

    onboot = true
    agent = 1
    qemu_os = "other"

    memory = 32768
    balloon = 16384
    sockets = 2
    cores = 4

    boot = "order=scsi0"

    scsihw = "virtio-scsi-pci"
    
    network {
        model = "virtio"
        bridge = "vmbr1"
    }

    disk {
        type = "scsi"
        size = "256G"
        storage = "pool01"
    }

    ssh_user = data.vault_generic_secret.ciuser.data["username"]
    ssh_private_key = data.vault_generic_secret.ciuser.data["ssh_priv"]

    os_type = "cloud-init"
    ipconfig0 = "ip=dhcp"

    ciuser = data.vault_generic_secret.ciuser.data["username"]
    cipassword = data.vault_generic_secret.ciuser.data["password"]
    sshkeys = data.vault_generic_secret.ciuser.data["ssh_pub"]

}

resource "proxmox_vm_qemu" "k3s-n02-16g-w01" {
    name = "k3s-n02-16g-w01"
    target_node = "watershed"
    clone = "ubuntu-server-jammy-watershed"

    onboot = true
    agent = 1
    qemu_os = "other"

    memory = 16384
    balloon = 8192
    sockets = 2
    cores = 3

    boot = "order=scsi0"

    scsihw = "virtio-scsi-pci"
    
    network {
        model = "virtio"
        bridge = "vmbr1"
    }

    disk {
        type = "scsi"
        size = "256G"
        storage = "pool01"
    }

    ssh_user = data.vault_generic_secret.ciuser.data["username"]
    ssh_private_key = data.vault_generic_secret.ciuser.data["ssh_priv"]

    os_type = "cloud-init"
    ipconfig0 = "ip=dhcp"

    ciuser = data.vault_generic_secret.ciuser.data["username"]
    cipassword = data.vault_generic_secret.ciuser.data["password"]
    sshkeys = data.vault_generic_secret.ciuser.data["ssh_pub"]

}

resource "proxmox_vm_qemu" "k3s-n02-16g-w02" {
    name = "k3s-n02-16g-w02"
    target_node = "watershed"
    clone = "ubuntu-server-jammy-watershed"

    onboot = true
    agent = 1
    qemu_os = "other"

    memory = 16384
    balloon = 8192
    sockets = 2
    cores = 3

    boot = "order=scsi0"

    scsihw = "virtio-scsi-pci"
    
    network {
        model = "virtio"
        bridge = "vmbr1"
    }

    disk {
        type = "scsi"
        size = "256G"
        storage = "pool01"
    }

    ssh_user = data.vault_generic_secret.ciuser.data["username"]
    ssh_private_key = data.vault_generic_secret.ciuser.data["ssh_priv"]

    os_type = "cloud-init"
    ipconfig0 = "ip=dhcp"

    ciuser = data.vault_generic_secret.ciuser.data["username"]
    cipassword = data.vault_generic_secret.ciuser.data["password"]
    sshkeys = data.vault_generic_secret.ciuser.data["ssh_pub"]

}

resource "proxmox_vm_qemu" "k3s-n02-8g-w01" {
    name = "k3s-n02-8g-w01"
    target_node = "watershed"
    clone = "ubuntu-server-jammy-watershed"

    onboot = true
    agent = 1
    qemu_os = "other"

    memory = 8192
    balloon = 4096
    sockets = 2
    cores = 2

    boot = "order=scsi0"

    scsihw = "virtio-scsi-pci"
    
    network {
        model = "virtio"
        bridge = "vmbr1"
    }

    disk {
        type = "scsi"
        size = "256G"
        storage = "pool01"
    }

    ssh_user = data.vault_generic_secret.ciuser.data["username"]
    ssh_private_key = data.vault_generic_secret.ciuser.data["ssh_priv"]

    os_type = "cloud-init"
    ipconfig0 = "ip=dhcp"

    ciuser = data.vault_generic_secret.ciuser.data["username"]
    cipassword = data.vault_generic_secret.ciuser.data["password"]
    sshkeys = data.vault_generic_secret.ciuser.data["ssh_pub"]

}

resource "proxmox_vm_qemu" "k3s-n02-8g-w02" {
    name = "k3s-n02-8g-w02"
    target_node = "watershed"
    clone = "ubuntu-server-jammy-watershed"

    onboot = true
    agent = 1
    qemu_os = "other"

    memory = 8192
    balloon = 4096
    sockets = 2
    cores = 2

    boot = "order=scsi0"

    scsihw = "virtio-scsi-pci"
    
    network {
        model = "virtio"
        bridge = "vmbr1"
    }

    disk {
        type = "scsi"
        size = "256G"
        storage = "pool01"
    }

    ssh_user = data.vault_generic_secret.ciuser.data["username"]
    ssh_private_key = data.vault_generic_secret.ciuser.data["ssh_priv"]

    os_type = "cloud-init"
    ipconfig0 = "ip=dhcp"

    ciuser = data.vault_generic_secret.ciuser.data["username"]
    cipassword = data.vault_generic_secret.ciuser.data["password"]
    sshkeys = data.vault_generic_secret.ciuser.data["ssh_pub"]

}