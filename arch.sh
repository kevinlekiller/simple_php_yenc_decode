#!/bin/sh

sudo pacman -S --needed gcc boost

gcc `php-config --includes` -fpic -c source/yenc_decode_wrap.cpp

if [ ! -e yenc_decode_wrap.o ]; then
    echo "Error creating yenc_decode_wrap.o!"
    exit 1
fi

gcc -fpic -c source/yenc_decode.cpp -lboost_regex

if [ ! -e yenc_decode.o ]; then
    echo "Error creating yenc_decode.o!"
    exit 2
fi

EXTENSIONS=`php-config --extension-dir`

if [ ! -e ${EXTENSIONS} ]; then
    echo "Error locating extensions directory ${EXTENSIONS}!"
    exit 3
fi

sudo gcc -shared *.o -o ${EXTENSIONS}/simple_php_yenc_decode.so -lboost_regex

if [ ! -e ${EXTENSIONS}/simple_php_yenc_decode.so ]; then
    echo "Error creating ${EXTENSIONS}/simple_php_yenc_decode.so!"
else
    echo "The extension was compiled successfully."
    sudo echo "extension=${EXTENSIONS}/simple_php_yenc_decode.so" > ./simple_php_yenc_decode.ini
    sudo cp -u ./simple_php_yenc_decode.ini /etc/php/conf.d/
    if [ ! -e /etc/php/conf.d/simple_php_yenc_decode.ini ]; then
        echo "There was an error creating the ini file to load the extension!"
    else
        echo "PHP has been succesfully set up to load the extension."
        echo "All done!"
    fi
fi
