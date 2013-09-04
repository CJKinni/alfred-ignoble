require 'foursquare2'
require 'nokogiri'

FourSqClient = Foursquare2::Client.new(:oauth_token => FOURSQ_OAUTH_TOKEN)

def returnRecentFoursqUpdate()
	recentCheckin = FourSqClient.user_checkins(:limit => 1)
	recentLocation = recentCheckin.items[0].venue.location

	@time       = Time.now
	@reducetime = @time - FOURSQ_UPDATE_TIME

	@created = Time.at(recentCheckin.items[0].createdAt)

	if @created.between?(@reducetime, @time)

		recentLat = recentLocation.lat
		recentLng = recentLocation.lng
		
		# Get a Nokogiri::HTML::Document for the page we’re interested in...
		url = 'http://api.wikilocation.org/articles?lat=', recentLat ,'&lng=', recentLng, '&limit=1&format=xml&radius=200000'
		url = url.join
		doc = Nokogiri::HTML(open(url))
		
		puts doc 
		# Do funky things with it using Nokogiri::XML::Node methods...

		locType, locTitle, locUrl = "new string" # Why do I need to do this.  Must investigate.  "undefined local variable or method `locUrl' for main:Object (NameError)" for all these.

		doc.xpath('//type').each do |link|
		  locType = link.content
		end

		doc.xpath('//title').each do |link|
		  locTitle = link.content
		end

		doc.xpath('//url').each do |link|
		  locUrl = link.content
		end

		if locType != ''
			locType = ", a ", locType
			locType = locType.join
		end
		
		shorturl = returnBitlyLink(locUrl)

		message =  "I noticed @ckinniburgh checked in to ", recentLocation.city ,". He might want to learn about ", locTitle , locType , ". ", shorturl
		message = message.join

		return message
	end
end