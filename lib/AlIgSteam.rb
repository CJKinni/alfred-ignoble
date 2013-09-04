require 'nokogiri'
require 'open-uri'

def returnPlayingSteam()
	url = "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=ACBDD3C3C8CD6FF034282B97593517B3&steamids=76561197965817780&format=xml"
	doc = Nokogiri::HTML(open(url))

	if doc.xpath('//gameextrainfo').first.nil? == false
		steamGame = doc.xpath('//gameextrainfo').first.content
		steamGame = steamGame[0..36]
		return "Hmm... @CKinniburgh is playing "+ steamGame +". I wonder why he thinks he has time to play when I'm always working."
	end
end