#!/bin/bash 
soft=redis
version=3.2.3
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ ! -d "/opt/app/bin" ]; then
  mkdir -p /opt/app/bin
fi
test -d /opt/down/${soft} && rm -rf /opt/down/${soft}
mkdir -p /opt/down/${soft}
cd /opt/down/${soft}
wget http://download.redis.io/releases/${soft}-${version}.tar.gz
tar xf  ${soft}-${version}.tar.gz
cd  ${soft}-${version}
make
make PREFIX=/opt/app/redis install
rm -rf /opt/app/bin/redis-cli
ln -s /opt/app/redis/bin/redis-cli /opt/app/bin/redis-cli


cd $DIR
if [ ! -d "/opt/app/redis/etc" ]; then
  mkdir -p /opt/app/redis/etc
fi

cp files/redis-6379.conf /opt/app/redis/etc/6379.conf


if [ ! -d "/data/logs/redis" ]; then
  mkdir -p /data/logs/redis
fi


if [ ! -d "/data/redis/6379" ]; then
  mkdir -p /data/redis/6379
fi


cp files/redis-6379 /etc/init.d/redis-6379
chmod +x  /etc/init.d/redis-6379
systemctl enable redis-6379

rm -rf /opt/down/${soft}

