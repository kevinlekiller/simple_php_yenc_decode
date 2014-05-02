#!/bin/sh
 
sudo apt-get install libboost-regex-dev -y
 
g++ `php-config5 --includes` -fpic -c source/yenc_decode_wrap.cpp
 
if [ ! -e yenc_decode_wrap.o ]; then
    echo "Error creating yenc_decode_wrap.o!"
    exit 1
fi
 
g++ -fpic -c source/yenc_decode.cpp -lboost_regex
 
if [ ! -e yenc_decode.o ]; then
    echo "Error creating yenc_decode.o!"
    exit 2
fi
 
PHP_API=`php-config --phpapi`
EXTENSIONS=/usr/lib/php5/${PHP_API}
 
if [ ! -e ${EXTENSIONS} ]; then
    echo "Error locating extensions directory ${EXTENSIONS}!"
    exit 3
fi
 
sudo g++ -shared *.o -o ${EXTENSIONS}/simple_php_yenc_decode.so -lboost_regex
 
if [ ! -e ${EXTENSIONS}/simple_php_yenc_decode.so ]; then
    echo "Error creating ${EXTENSIONS}/simple_php_yenc_decode.so!"
else
    echo "Compiled successfully!"
    sudo echo "extension=${EXTENSION}/simple_php_yenc_decode.so" > ./simple_php_yenc_decode.ini
    sudo cp -u ./simple_php_yenc_decode.ini /etc/php5/mods-available/
    sudo ln -s /etc/php5/mods-available/simple_php_yenc_decode.ini /etc/php5/cli/conf.d/simple_php_yenc_decode.ini
fi
