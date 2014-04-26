#!/bin/sh

sudo apt-get install libboost-regex-dev

g++ `php-config5 --includes` -fpic -c source/yenc_decode_wrap.cpp

if [ ! -e yenc_decode_wrap.o ]; then
    echo "Error creating yenc_decode_wrap.o!"
	exit 1
fi

g++ -fpic -c source/yenc_decode.cpp -lboost_regex

if [ ! -e yenc_decode.o ]; then
    echo "Error creating yenc_decode.o!"
	exit 1
fi

sudo mkdir -p /usr/lib/php5/extensions

if [ ! -e /usr/lib/php5/extensions ]; then
    echo "Error creating directory /usr/lib/php5/extensions!"
	exit 1
fi

sudo g++ -shared *.o -o /usr/lib/php5/extensions/simple_php_yenc_decode.so -lboost_regex

if [ ! -e /usr/lib/php5/extensions/simple_php_yenc_decode.so ]; then
    echo "Error creating /usr/lib/php5/extensions/simple_php_yenc_decode.so!"
else
    echo "Compiled successfully!"
	echo "Now add extension=/usr/lib/php5/extensions/simple_php_yenc_decode.so to /etc/php5/cli/php.ini in the Dynamic Extensions section."
fi