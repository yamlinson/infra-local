provider "vault" {
    address = var.VAULT_ADDR
    token = var.VAULT_TOKEN
    skip_child_token = true
}

data "vault_generic_secret" "pve_api" {
    path = "kv/proxmox"
}

provider "proxmox" {

    pm_api_url = data.vault_generic_secret.pve_api.data["pve_api_url"]
    pm_api_token_id = data.vault_generic_secret.pve_api.data["pve_api_token_id"]
    pm_api_token_secret = data.vault_generic_secret.pve_api.data["pve_api_token_secret"]

    pm_tls_insecure = true

    pm_parallel = 2
    pm_timeout = 3600
    
}