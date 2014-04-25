<?php
if (extension_loaded('simple_php_yenc_decode')) {
	var_dump(simple_yenc_decode(file_get_contents('yEnc.txt')));
} else {
	echo 'The simple_php_yenc_decode extension is not loaded!', PHP_EOL;
}