<?php
if (extension_loaded('simple_php_yenc_decode')) {
	file_put_contents('yEnc.zip', simple_yenc_decode(file_get_contents('yEnc.zip.yEnc')));
	if (is_file('yEnc.zip')) {
		echo 'The yEnc decode was successful, you can now unzip yEnc.zip and run the html file in a browser to verify the result.', PHP_EOL;
	} else {
		echo 'There was a problem writing or reading the zip file.', PHP_EOL;
	}
} else {
	echo 'The simple_php_yenc_decode extension is not loaded!', PHP_EOL;
}