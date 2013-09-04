require 'bitly'

#######################################################################
#
#	Bitly Library for AlfredIgnoble
#
#	Functions:
#	returnBitlyLink(url)
#		Returns a short url from a full url
#
#######################################################################

def returnBitlyLink(url)
	Bitly.use_api_version_3

	bitly = Bitly.new(BITLY_NAME, BITLY_PASS) # Are these the right names?
	shortUrl = bitly.shorten(url).short_url

	return shortUrl
end