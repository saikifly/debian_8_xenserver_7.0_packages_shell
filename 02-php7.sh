#!/bin/bash 
soft=php
version=7.0.9
extensions=(
"yaf" "3.0.3" ""
"yar" "2.0.1" "--enable-msgpack"
"yac" "2.0.1" ""
"SeasLog" "1.6.2" ""
"swoole" "1.8.8" "--enable-thread --enable-async-redis --enable-sockets"
"msgpack" "2.0.1" ""
"yaconf" "1.0.2" ""
"redis" "3.0.0" ""
"gmagick" "2.0.4RC1" "--with-gmagick=/opt/app/graphicsmagick"
)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
test -d /opt/down/${soft} && rm -rf /opt/down/${soft}
mkdir -p /opt/down/${soft}
cd /opt/down/${soft}
wget http://cn2.php.net/get/php-${version}.tar.xz/from/this/mirror -O php-${version}.tar.xz
tar xf  php-${version}.tar.xz
cd  ${soft}-${version}

./configure  --prefix=/opt/app/php-7.0 --enable-fpm --with-config-file-path=/opt/app/php-7.0/etc --with-config-file-scan-dir=/opt/app/php-7.0/etc/conf.d --disable-cgi --disable-ipv6 --enable-pcntl --enable-gd-native-ttf --with-freetype-dir --with-gd --enable-bcmath --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-mysqlnd --enable-exif --enable-sockets --enable-mbstring --enable-zip --with-jpeg-dir --with-openssl --with-png-dir --with-zlib --with-mhash --with-curl --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd

make && make install
export PATH=$PATH:/opt/app/php-7.0/bin
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
rm -rf /opt/app/php-7.0/etc/php-fpm*
cp files/php-fpm-70.conf /opt/app/php-7.0/etc/php-fpm.conf
cp files/php-fpm-70 /etc/init.d/
cp files/php-70.ini /opt/app/php-7.0/etc/php.ini
chmod +x /etc/init.d/php-fpm-70
systemctl enable php-fpm-70
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

ln -s /opt/app/php-7.0/bin/php /opt/app/bin/php
ln -s /opt/app/php-7.0/sbin/php-fpm /opt/app/sbin/php-fpm


