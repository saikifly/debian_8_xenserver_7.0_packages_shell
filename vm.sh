#!/bin/bash 
IP=192.168.3.61
HOSTNAME=vm-3061

echo "127.0.0.1	localhost
127.0.1.1 ${HOSTNAME}
">/etc/hosts
echo "${HOSTNAME}">/etc/hostname
echo "source /etc/network/interfaces.d/*
auto lo
iface lo inet loopback
auto eth0
iface eth0 inet static
  address ${IP}
  netmask 255.255.252.0
  gateway 192.168.2.254
">/etc/network/interfaces

echo "Port 22
ListenAddress ${IP}
Protocol 2
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_dsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key
UsePrivilegeSeparation yes
KeyRegenerationInterval 3600
ServerKeyBits 1024
SyslogFacility AUTH
LogLevel INFO
LoginGraceTime 120
PermitRootLogin without-password
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
IgnoreRhosts yes
RhostsRSAAuthentication no
HostbasedAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes
UseDNS no
"> /etc/ssh/sshd_config
