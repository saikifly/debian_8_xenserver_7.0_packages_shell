#!/bin/bash 

soft=percona
version=0.1-3
apt-get -y purge percona*
test -d /opt/down/${soft} && rm -rf /opt/down/${soft}
mkdir -p /opt/down/${soft} 
cd /opt/down/${soft}
wget https://repo.percona.com/apt/percona-release_${version}.$(lsb_release -sc)_all.deb
dpkg -i percona-release_${version}.$(lsb_release -sc)_all.deb
apt-get update
export DEBIAN_FRONTEND=noninteractive
apt-get -q  -y install percona-server-server-5.7
rm -rf /opt/down/${soft}
cd /
service mysql stop
systemctl disable mysql

