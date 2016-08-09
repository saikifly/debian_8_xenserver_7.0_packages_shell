#!/bin/bash 
soft=php
version=5.3.29
extensions=(
"memcache" "3.0.8" ""
"gearman" "1.1.2" "--with-gearman=/opt/app/gearmand"
"memcached" "2.2.0" "--disable-memcached-sasl"
"yaf" "2.3.5" ""
"yar" "1.2.5" "--enable-msgpack"
"yac" "0.9.2" ""
"SeasLog" "1.6.2" ""
"swoole" "1.8.8" "--enable-thread --enable-async-redis --enable-sockets"
"msgpack" "0.5.7" ""
"zendopcache" "7.0.5" ""
"redis" "2.2.8" ""
"gmagick" "1.1.7RC3" "--with-gmagick=/opt/app/graphicsmagick"
)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
test -d /opt/down/${soft} && rm -rf /opt/down/${soft}
mkdir -p /opt/down/${soft}
cd /opt/down/${soft}
wget http://cn2.php.net/get/php-${version}.tar.xz/from/this/mirror -O php-${version}.tar.xz
tar xf  php-${version}.tar.xz
cd  ${soft}-${version}

ln -s /usr/include/freetype2 /usr/include/freetype
mkdir /usr/include/freetype2/freetype
ln -s /usr/include/freetype2/freetype.h /usr/include/freetype2/freetype/freetype.h
./configure  --prefix=/opt/app/php-5.3 --enable-fpm --with-config-file-path=/opt/app/php-5.3/etc --with-config-file-scan-dir=/opt/app/php-5.3/etc/conf.d --disable-cgi --disable-ipv6 --enable-pcntl --enable-gd-native-ttf --with-freetype-dir --with-gd --enable-bcmath --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-mysqlnd --enable-exif --enable-sockets --enable-mbstring --enable-zip --with-jpeg-dir --with-png-dir --with-zlib --with-mhash --with-curl --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd
# openssl failed
make && make install
export PATH=$PATH:/opt/app/php-5.3/bin
cd /opt/down/${soft}

for ((i=0; i<${#extensions[@]}; i=i+3))  
do  
    cd /opt/down/${soft}
    wget https://pecl.php.net/get/${extensions[i]}-${extensions[i+1]}.tgz 
	tar xf ${extensions[i]}-${extensions[i+1]}.tgz 
	cd ${extensions[i]}-${extensions[i+1]}
	phpize
    ./configure ${extensions[i+2]}
	make && make install
done  
cd $DIR
rm -rf /opt/app/php-5.3/etc/php-fpm*
cp files/php-fpm-53.conf /opt/app/php-5.3/etc/php-fpm.conf
cp files/php-fpm-53 /etc/init.d/
cp files/php-53.ini /opt/app/php-5.3/etc/php.ini
chmod +x /etc/init.d/php-fpm-53
systemctl enable php-fpm-53
useradd php
rm -rf /opt/down/${soft}
if [ ! -d "/opt/app/bin" ]; then
  mkdir -p /opt/app/bin
fi
if [ ! -d "/opt/app/sbin" ]; then
  mkdir -p /opt/app/sbin
fi
if [ ! -d "/data/logs/php" ]; then
  mkdir -p /data/logs/php
fi

ln -s /opt/app/php-5.3/bin/php /opt/app/bin/php53
ln -s /opt/app/php-5.3/sbin/php-fpm /opt/app/sbin/php-fpm-53



