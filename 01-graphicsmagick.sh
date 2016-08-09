#!/bin/bash
soft=GraphicsMagick
version=1.3.24
test -d /opt/down/${soft} && rm -rf /opt/down/${soft}
mkdir -p /opt/down/${soft} 
cd /opt/down/${soft}
wget http://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/1.3.24/${soft}-${version}.tar.xz
tar xf  ${soft}-${version}.tar.xz
cd  ${soft}-${version}
./configure --prefix=/opt/app/graphicsmagick --with-windows-font-dir=/opt/app/ttf --enable-shared
make 
make install
cd /opt/down
rm -rf /opt/down/${soft}
if [ ! -d "/opt/app/bin" ]; then
  mkdir -p /opt/app/bin
fi
ln -s /opt/app/graphicsmagick/bin/gm /opt/app/bin/gm


