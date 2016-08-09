#!/bin/bash 
if [ ! -d "/opt/app/bin" ]; then
  mkdir -p /opt/app/bin
fi
cd /opt/app/bin
rm -rf composer.phar composer 
wget https://getcomposer.org/composer.phar
chmod +x /opt/app/bin/composer.phar 
ln -s /opt/app/bin/composer.phar /opt/app/bin/composer
#/opt/app/bin/composer selfupdate 

