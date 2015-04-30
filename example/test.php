<?php

if (!extension_loaded('simple_php_yenc_decode')) {
	exit('The simple_php_yenc_decode extension is not loaded!' . PHP_EOL);
}

$cwd = getcwd();
if (!$cwd) {
	exit('Error getting the current working directory.' . PHP_EOL);
}
$cwd .= DIRECTORY_SEPERATOR;

$file = $cwd . 'yEnc.zip.yEnc';
if (!is_file($file)) {
	exit('Error: File not found: ' . $file . PHP_EOL);
}

file_put_contents($cwd . 'yEnc.zip', simple_yenc_decode(file_get_contents($file)));
if (!is_file($cwd . 'yEnc.zip')) {
	exit('There was a problem writing or reading the zip file.' . PHP_EOL);
}

echo 'The yEnc decode was successful, you can now unzip yEnc.zip and run the html file in a browser or view it in a text editor to verify the result.' . PHP_EOL;
