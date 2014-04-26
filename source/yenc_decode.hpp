#include <iostream>
#include <boost/regex.hpp>
/**
 * Decodes a yEnc string, ignores all yEnc checks (length/crc32/etc).
 *
 * @note If string is not yEnc, empty string is returned.
 * 
 * @param std::string data yEnc data to parse.
 *
 * @return string On success: Decoded yEnc.
 *                On failure: Empty string.
 */
std::string simple_yenc_decode(const std::string data);