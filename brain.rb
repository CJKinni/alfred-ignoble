#!/usr/bin/ruby
require 'require_all'
Dir.chdir("/home/ckinniburgh/AlIg")
require_all '/home/ckinniburgh/AlIg/lib'

def morningWakeup()
	sendToTwitter(returnWeatherForeDescrip())
	sendToTwitter(returnWeatherForeTemps())
	sendToTwitter(returnFitYesterdaySteps())
	sendToTwitter(returnFitWeightChange())
end

def hourly()
	sendToTwitter(returnCodeThanks())
end

def fiveMinute()
	sendToTwitter(returnRecentFoursqUpdate())
	#respondToTwitReplyJoke()
	sendToTwitter(passFuncRand(returnCurrentTrack(),20))
	sendToTwitter(passFuncWeekDay(passFuncRand(returnPlayingXbox(),60)))
	sendToTwitter(passFuncWeekDay(passFuncRand(returnPlayingSteam(),60)))
end


case ARGV[0]
when "morn"
	morningWakeup()
when "hourly"
	hourly()
when "fivemin"
	fiveMinute()
else
	puts "No Valid Argument Passed."
end
