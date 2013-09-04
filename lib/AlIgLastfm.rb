require 'lastfm'

def returnCurrentTrack()
	lastfm = Lastfm.new(LASTFM_KEY, LASTFM_SECRET)
	descriptionListening = ["Rocking out to ", "Listening to ", "Taking a break and singing ", "Humming ", "Thinking about the lyrics to ", "Dancing to "]

	lastFMPlayingTime = lastfm.user.get_recent_tracks(:limit => 2, :user => 'ckinniburgh').first["date"]["uts"].to_i
	if (Time.now.to_i - lastFMPlayingTime) < 300
		track = lastfm.user.get_recent_tracks(:limit => 1, :user => 'ckinniburgh').first["name"] 
		artist = lastfm.user.get_recent_tracks(:limit => 1, :user => 'ckinniburgh').first["artist"]["content"]	
		descript = descriptionListening[rand(descriptionListening.count)]
		message = descript + track + " by " + artist + " with @CKinniburgh."
		return message
	end
end
