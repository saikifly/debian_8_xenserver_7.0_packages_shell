#!/bin/bash 
soft=openresty
version=1.9.15.1
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
test -d /opt/down/${soft} && rm -rf /opt/down/${soft}
mkdir -p /opt/down/${soft} 
cd /opt/down/${soft}
wget https://openresty.org/download/${soft}-${version}.tar.gz
tar xf  ${soft}-${version}.tar.gz
cd  ${soft}-${version}

./configure --prefix=/opt/app/openresty --sbin-path=/opt/app/sbin/nginx --conf-path=/opt/app/nginx/conf/nginx.conf --http-log-path=/data/logs/nginx/access.log --error-log-path=/data/logs/nginx/error.log --lock-path=/opt/app/nginx/nginx.lock --pid-path=/opt/app/nginx/nginx.pid --http-client-body-temp-path=/opt/app/nginx/temp/body --http-fastcgi-temp-path=/opt/app/nginx/temp/fastcgi --http-proxy-temp-path=/opt/app/nginx/temp/proxy --with-http_addition_module --with-http_image_filter_module --with-http_ssl_module --with-http_realip_module --with-http_stub_status_module --with-http_sub_module --with-http_gzip_static_module --with-stream --with-stream_ssl_module --with-http_dav_module --with-threads --without-http_uwsgi_module --without-http_scgi_module --without-mail_pop3_module --without-mail_imap_module --without-mail_smtp_module --with-pcre-jit

make -j 8

make install 

if [ ! -d "/opt/app/nginx/temp" ]; then
  mkdir -p /opt/app/nginx/temp
fi


rm  -rf /opt/down/${soft}

useradd web
cd $DIR
cp files/nginx /etc/init.d/nginx
chmod +x /etc/init.d/nginx
systemctl enable nginx

