simple_php_yenc_decode
======================

Basic yEnc decoder extension for PHP5 written in c++ using swig.

### Intro:

The intention of this extension is to be used with nZEDb for decoding
partial yEnc articles from usenet, where the yEnc checks are not needed.

If the method fails or if the string is not yEnc, an empty string is returned.

Boost regex is used since it's easier to get working on windows than g++
and gcc's regex is not working until 4.9 (currently 4.7/4.8 are the popular versions).
Not that I'm compiling on windows, but if someone were to compile on windows,
it makes it easier for them.

### Included binary:

The included binary was compiled on ubuntu 14.04 x64, no guaranties it will work
on any other linux distro. If you have a windows binary, send a pull request and
I will add it to the binaries folder.

To download the included binary on linux:

`wget https://github.com/kevinlekiller/simple_php_yenc_decode/raw/master/binaries/linux/simple_php_yenc_decode.so`

### Compilation:

I've compiled the binary in ubuntu 14.04 x64, as long as you have all the requirements
you can compile on any operating system.

Swig is not required, since I offer the swig output files with the source, but
if you want to create the swig output files, I used swig 2.0, this was the command:

`swig -php -c++ yenc_decode.i`

For the rest, only boost regex is required, my g++ is 4.8.2 for reference and boost regex is 1.55:

``g++ `php-config5 --includes` -fpic -c yenc_decode_wrap.cpp``

`g++ -fpic -c php_yenc.cpp -lboost_regex`

Change this last line based on your OS (.dll instead of .so for windows for example).

`g++ -shared *.o -o php_yenc.so -lboost_regex`

### Installation:

If you compiled, you end up with a .so or .dll file.

You can also download a pre-made binary for linux (see the Included Binary section).

My php.ini didn't have a default "extensions" dir,

I created a extensions folder in /usr/lib/php5 and put the so file in there.

The location does not matter - I'm mentioning it so you can have an example of a place to put the extension.

Next you need to edit php.ini, the CLI one, since we only use yEnc decoding in CLI on nZEDb.

On ubuntu the CLI php.ini is here: /etc/php5/cli/php.ini

In the Dynamic Extensions part of the ini, add the extension:

At this point you have 2 choices, you can set the default location where extensions are loaded
to the folder we created above, or you can load the full path to the extension.

This is the full path:

extension=/usr/lib/php5/extensions/simple_php_yenc_decode.so

If you set the default location:

extension=simple_php_yenc_decode.so

### Example:

The example (test.php) checks if you have the extension loaded, then it tries to decode
the file called yEnc.txt which is a wikipedia HTML page encoded with yEnc.

If you see the HTML output, then it worked.

