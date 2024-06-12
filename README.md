# infra-local

Automation and documentation for setting up (my) local server environment

## Manual pre-tasks

### Proxmox

- Install PVE
- Install sudo
- Copy SSH key to root account
- Set up networks
    - Use vmbr0 for management and vmbr1 for servers

## Ansible

- Make sure ssh config allows ssh with host names listed in hosts.yml, like `ssh host`
- Run main.yml

