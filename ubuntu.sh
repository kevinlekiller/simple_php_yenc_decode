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
EXTENSIONS="/usr/lib/php5/${PHP_API}"
 
if [ ! -e ${EXTENSIONS} ]; then
    echo "Error locating extensions directory ${EXTENSIONS}!"
    exit 3
fi
 
sudo g++ -shared *.o -o ${EXTENSIONS}/simple_php_yenc_decode.so -lboost_regex
 
if [ ! -e ${EXTENSIONS}/simple_php_yenc_decode.so ]; then
    echo "Error creating ${EXTENSIONS}/simple_php_yenc_decode.so!"
else
    echo "The extension was compiled successfully."
    sudo echo "extension=${EXTENSIONS}/simple_php_yenc_decode.so" > ./simple_php_yenc_decode.ini
    sudo cp -u ./simple_php_yenc_decode.ini /etc/php5/mods-available/
    if [ ! -e /etc/php5/cli/conf.d/simple_php_yenc_decode.ini ]; then
        sudo ln -s /etc/php5/mods-available/simple_php_yenc_decode.ini /etc/php5/cli/conf.d/simple_php_yenc_decode.ini
        if [ ! -e /etc/php5/cli/conf.d/simple_php_yenc_decode.ini ]; then
            echo "There was a problem moving the ini file (used to load to extension) to /etc/php5/mods-available/"
        else
            echo "PHP has been succesfully set up to load the extension."
            echo "All done!"
        fi
    else
        echo "There was an error creating the ini file to load the extension!"
    fi
fi
