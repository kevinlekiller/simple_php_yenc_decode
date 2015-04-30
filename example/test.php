<?php

if (!extension_loaded('simple_php_yenc_decode')) {
	exit('The simple_php_yenc_decode extension is not loaded!' . PHP_EOL);
}

$dir = __DIR__ . DIRECTORY_SEPARATOR;

$file = $dir . 'yEnc.zip.yEnc';
if (!is_file($file)) {
	exit('Error: File not found: ' . $file . PHP_EOL);
}

file_put_contents($dir . 'yEnc.zip', simple_yenc_decode(file_get_contents($file)));
if (!is_file($dir . 'yEnc.zip')) {
	exit('There was a problem writing or reading the zip file.' . PHP_EOL);
}

echo 'The yEnc decode was successful, you can now unzip yEnc.zip and run the html file in a browser or view it in a text editor to verify the result.' . PHP_EOL;
