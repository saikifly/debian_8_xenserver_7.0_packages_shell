#!/bin/bash 
IP=192.168.3.60
HOSTNAME=vm-3060
DNS1=119.29.29.29
DNS2=223.5.5.5
NTP=192.168.1.82
SALTMASTER=salt.kongfz.com
SALTID=vm-3060

apt-get update
apt-get -y upgrade
apt-get -y install libwebp-dev  libgraphviz-dev  libgif-dev libtiff-dev libjbig-dev build-essential checkinstall   libx11-dev libxext-dev zlib1g-dev libpng12-dev   libjpeg-dev libfreetype6-dev libxml2-dev  zlib1g-dev  libfreetype6-dev curl sudo zerofree openssh-server vim linux-headers-amd64  htop iftop iotop strace ltrace screen unzip build-essential module-assistant  libpcre3-dev libgd2-noxpm-dev libpng12-dev  libjpeg-dev libssl-dev autoconf libhiredis-dev libnghttp2-dev libcurl4-openssl-dev chrony salt-minion zabbix-agent memcached libboost-all-dev gperf libevent-dev uuid-dev libmemcached-dev libmysqlclient-dev libtokyocabinet-dev
module-assistant prepare
systemctl disable memcached
/etc/init.d/memcached stop
apt-get -y remove nfs-common rpcbind acpid bluetooth bluez dbus
apt-get -y autoremove
echo "GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=\"debian vm\"
GRUB_CMDLINE_LINUX_DEFAULT=\"ipv6.disable=1 quiet\"
GRUB_CMDLINE_LINUX=\"ipv6.disable=1 quiet\"
" > /etc/default/grub
update-grub
echo "*   hard rss  unlimited
*   soft rss unlimited
*   soft cpu unlimited
*   hard cpu unlimited
*   hard fsize unlimited
*   soft fsize unlimited
*   soft nofile 1048576
*   hard nofile 1048576
*   soft nproc 1048576
*   hard nproc 1048576
*   soft sigpending 1048576
*   hard sigpending 1048576
" >/etc/security/limits.conf
echo "fs.file-max = 1048576
kernel.core_uses_pid = 1
kernel.hung_task_check_count = 4194304
kernel.hung_task_panic = 0
kernel.hung_task_timeout_secs = 0
kernel.hung_task_warnings = 0
kernel.msgmax = 65536
kernel.msgmnb = 65536
kernel.msgmni=32768
kernel.panic = 60
kernel.sem =5010 641280 5010 128
kernel.shmall = 4294967296
kernel.shmmax = 68719476736
kernel.sysrq = 0
net.core.netdev_max_backlog =  32768
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.somaxconn = 32768
net.core.wmem_default = 8388608
net.core.wmem_max = 16777216
net.ipv4.conf.all.accept_redirects = 1
net.ipv4.conf.all.accept_source_route = 1
net.ipv4.conf.all.forwarding = 1
net.ipv4.conf.all.log_martians = 0
net.ipv4.conf.all.rp_filter = 0
net.ipv4.conf.all.send_redirects = 1
net.ipv4.conf.default.accept_redirects = 1
net.ipv4.conf.default.accept_source_route = 1
net.ipv4.conf.default.forwarding = 1
net.ipv4.conf.default.log_martians = 0
net.ipv4.conf.default.rp_filter = 0
net.ipv4.conf.default.send_redirects = 1
net.ipv4.icmp_echo_ignore_all = 0
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.icmp_ignore_bogus_error_responses = 1
net.ipv4.ip_forward = 1
net.ipv4.ipfrag_high_thresh = 512000
net.ipv4.ipfrag_low_thresh = 446464
net.ipv4.ip_local_port_range = 32768 61000
net.ipv4.neigh.default.gc_interval = 5
net.ipv4.neigh.default.gc_stale_time = 120
net.ipv4.neigh.default.gc_stale_time = 120
net.ipv4.neigh.default.gc_thresh1 = 4096
net.ipv4.neigh.default.gc_thresh2 = 8192
net.ipv4.neigh.default.gc_thresh3 = 16384
net.ipv4.neigh.default.proxy_qlen = 96
net.ipv4.neigh.default.unres_qlen = 6
net.ipv4.route.flush = 1
net.ipv4.tcp_congestion_control = cubic
net.ipv4.tcp_dsack = 0
net.ipv4.tcp_fack = 0
net.ipv4.tcp_fin_timeout = 32
net.ipv4.tcp_keepalive_intvl = 32
net.ipv4.tcp_keepalive_probes = 13
net.ipv4.tcp_keepalive_time = 512
net.ipv4.tcp_max_orphans = 262144
net.ipv4.tcp_max_syn_backlog = 65535
net.ipv4.tcp_max_tw_buckets = 13107200
net.ipv4.tcp_moderate_rcvbuf = 0
net.ipv4.tcp_no_metrics_save = 0
net.ipv4.tcp_retries1 = 3
net.ipv4.tcp_retries2 = 15
net.ipv4.tcp_rfc1337 = 1
net.ipv4.tcp_rmem = 4096 65536 16777216
net.ipv4.tcp_sack = 0
net.ipv4.tcp_synack_retries = 4
net.ipv4.tcp_syncookies = 0
net.ipv4.tcp_syn_retries = 5
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_wmem = 4096 16384 16777216
net.ipv4.udp_mem = 65536 173800 419430
net.ipv4.udp_rmem_min = 65536
net.ipv4.udp_wmem_min = 65536
vm/min_free_kbytes = 65536
vm.mmap_min_addr = 4096
vm.overcommit_memory=1
vm.swappiness = 1
net.ipv4.conf.all.arp_notify = 1
" >/etc/sysctl.conf
sysctl -p


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

echo "127.0.0.1	localhost
127.0.1.1 ${HOSTNAME}
">/etc/hosts
echo "${HOSTNAME}">/etc/hostname
sed -i 's/export\ PATH/export\ PATH=\$PATH:\/opt\/app\/bin:\/opt\/app\/sbin/g' /etc/profile

echo "PS1='\${debian_chroot:+(\$debian_chroot)}\h:\w\\$ '
umask 022
export LS_OPTIONS='--color=auto'
eval \"\`dircolors\`\"
alias ls='ls \$LS_OPTIONS'
alias ll='ls \$LS_OPTIONS -l'
alias l='ls \$LS_OPTIONS -lA'
export PATH=\$PATH:/opt/app/bin:/opt/app/sbin
"> ~/.bashrc
echo "nameserver ${DNS1}
nameserver ${DNS2}
">/etc/resolv.conf

echo "server ${NTP}
port 0
cmdport 0
bindcmdaddress 127.0.0.1
keyfile /etc/chrony/chrony.keys
commandkey 1
driftfile /var/lib/chrony/chrony.drift
log tracking measurements statistics
logdir /var/log/chrony
maxupdateskew 100.0
dumponexit
dumpdir /var/lib/chrony
local stratum 10
logchange 0.5
rtconutc
">/etc/chrony/chrony.conf
echo "master: ${SALTMASTER}
id: ${SALTID}
">/etc/salt/minion
echo "${SALTID}">/etc/salt/minion_id

usermod -a -G sudo luye
#visudo
echo "Defaults	env_reset
Defaults	mail_badpass
Defaults	secure_path=\"/opt/app/bin:/opt/app/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\"
root	ALL=(ALL:ALL) ALL
%sudo	ALL=(ALL) NOPASSWD:ALL
">/etc/sudoers
