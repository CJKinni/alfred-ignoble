require 'gamertag'

def returnPlayingXbox()
	xboxOnline = Gamertag.profile('ckinni')["online"]

	if xboxOnline == true
		xboxPresence = Gamertag.profile('ckinni')["presence"]
		xboxPresence = xboxPresence[0..42]
		return "Hmm... @CKinniburgh is using his Xbox again. Maybe he should spend more time working instead of " + xboxPresence + "."
	end
end