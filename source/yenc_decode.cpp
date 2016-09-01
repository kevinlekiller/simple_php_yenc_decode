#include "yenc_decode.hpp"
std::string simple_yenc_decode(const std::string data)
{
	std::string encodedYenc = "";
	std::string decodedYenc = "";
	try {
		boost::smatch match;
		const boost::regex pattern(
			"^.*y(part|begin).+?[\r\n](.+)[\r\n]{1,2}=yend",
			boost::regex::icase
		);

		if (boost::regex_search (data, match, pattern)) {
			encodedYenc = match[2];
		}
	} catch(...) {}

	if (encodedYenc != "") {
		for (unsigned long i = 0; i < encodedYenc.length(); i++) {
			if (encodedYenc[i] == '\r' || encodedYenc[i] == '\n') {
				continue;
			} else if (encodedYenc[i] == '=') {
				i++;
				decodedYenc += ((encodedYenc[i] + 150) % 256);
			} else {
				decodedYenc += ((encodedYenc[i] + 214) % 256);
			}
		}
	}
	return decodedYenc;
}
