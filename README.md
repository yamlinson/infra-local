# infra-local

Automation and documentation for setting up (my) local server environment

## Manual pre-tasks

### Main PVE hosts

- Install PVE
- Install sudo
- Copy SSH key to root account
- Set up networks
  - Use vmbr0 for management and vmbr1 for servers

### Extra voter

- Install Debian
- Install sudo
- Add ansible user

## Ansible

- Make sure ssh config allows ssh with host names listed in hosts.yml, like `ssh host`
- Run main.yml

## Packer

Packer will start an HTTP server on a random (configurable) port to host the kickstart file.
The machine running Packer will need to be accessible to the new machine over this port.

- (Optionally) sync this project to a jump box or similar with `./sync.sh`
- Get a vault token with `. env.sh`
- `packer build -var "node=pve01" packer/rocky-9/` builds to a node called "pve01"

### Resources

- [Proxmox ISO builder](https://developer.hashicorp.com/packer/integrations/hashicorp/proxmox/latest/components/builder/iso)
- [Rocky Packer Template Creation](https://docs.rockylinux.org/guides/automation/templates-automation-packer-vsphere/)
- [CentOS Kickstart 2 Syntax Guide](https://docs.centos.org/en-US/centos/install-guide/Kickstart2/)
- [Rocky9 Kickstart Templates](https://github.com/rocky-linux/kickstarts/tree/r9)
- [Cloud Init configuration](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/configuring_and_managing_cloud-init_for_rhel_8/configuring-cloud-init_cloud-content#changing-a-default-user-name-with-cloud-init_configuring-cloud-init)
