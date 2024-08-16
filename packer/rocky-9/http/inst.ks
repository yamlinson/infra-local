ignoredisk --only-use=sda
clearpart --none --initlabel

text
cdrom
lang en_us.UTF-8
keyboard us
timezone Etc/UTC --utc

network --bootproto=dhcp --device=ens18 --activate
network --hostname=rockytpl

repo --name="AppStream" --baseurl=file:///run/install/repo/AppStream

rootpw Packer

firstboot --disabled
eula --agreed

skipx

services --disabled="kdump" --enabled="sshd,rsyslog,chronyd"

autopart --nohome --type=lvm
bootloader --location=mbr --boot-drive=sda --append="systemd.journald.forward_to_console=1 console=ttyS0,38400 console=tty1"

firewall --service=ssh

selinux --enforcing

reboot

%packages --ignoremissing --excludedocs
@^minimal-environment
kmod-mptsas
openssh-clients
openssh-server
curl
dnf-utils
net-tools
sudo
vim
wget
qemu-guest-agent
cloud-init
cloud-utils-growpart
python3
python3-libselinux
python3-jsonschema

-aic94xx-firmware
-alsa-*
-atmel-firmware
-b43-openfwwf
-bfa-firmware
-fprintd-pam
-ipw*-firmware
-ivtv-firmware
-iwl*-firmware
-libertas-usb8388-firmware
-microcode_ctl
-ql*-firmware
-rt61pci-firmware
-rt73usb-firmware
-xorg-x11-drv-ati-firmware
-zd1211-firmware

-cockpit
-intltool
-quota

%end

%addon com_redhat_kdump --disable
%end

%post
sed -e 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' -i /etc/ssh/sshd_config
%end
