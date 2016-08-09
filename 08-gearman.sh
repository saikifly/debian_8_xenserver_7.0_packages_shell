#!/bin/bash 
soft=gearmand
version=1.1.12

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ ! -d "/opt/app/bin" ]; then
  mkdir -p /opt/app/bin
fi
test -d /opt/down/${soft} && rm -rf /opt/down/${soft}
mkdir -p /opt/down/${soft}
cd /opt/down/${soft}

wget https://launchpad.net/gearmand/1.2/${version}/+download/${soft}-${version}.tar.gz

tar xf  ${soft}-${version}.tar.gz
cd  ${soft}-${version}
./configure --prefix=/opt/app/gearmand --with-sqlite3=no --disable-libdrizzle  --disable-libpq  --with-mysql=yes
make && make install
ln -s /opt/app/gearmand/bin/gearman /opt/app/bin/gearman
ln -s /opt/app/gearmand/bin/gearadmin /opt/app/bin/gearadmin
cd $DIR
cp files/gearman /etc/init.d/gearman
chmod +x /etc/init.d/gearman

