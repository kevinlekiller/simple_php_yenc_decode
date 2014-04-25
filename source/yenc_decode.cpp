#include "yenc_decode.hpp"
std::string simple_yenc_decode(const std::string data)
{
	std::string encodedYenc = "";
	std::string decodedYenc = "";
	try {
		boost::smatch match;
		const boost::regex pattern(
			"=ybegin.*?\r\n(.*)\r\n=yend", 
			boost::regex_constants::icase
		);

		if (boost::regex_search (data, match, pattern)) {
			encodedYenc = match[1];
		}
	} catch (boost::regex_error& e) {}

	if (encodedYenc != "") {
		for (unsigned long i = 0; i < encodedYenc.length(); i++) {
			if (encodedYenc[i] == '\r') {
				if (encodedYenc[i] + 2 == '.') {
					i++;
				}
				i++;
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