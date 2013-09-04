# encoding: utf-8
require 'yahoo_weatherman'

#######################################################################
#
#	Yahoo Weather Library for AlfredIgnoble
#
#	Functions:
#	returnWeatherForeDescrip() 
#		Returns a comment about today's weather. 
#
#	returnWeatherForeTemps()
#		Returns a description of the temperature.
#
#	To Do:
#	* Allow a message to be past for different days forecasts.
#	* Add option for today's temp.
#	* Set WOEID by location.
#	* Allow optional call to functions with different location.
#	* Fix .joins if appropriate.
#	* check return syntax.
#	
#######################################################################

def returnWeatherForeDescrip()
	weatherClient = Weatherman::Client.new( :unit => WEATHER_UNITS )
	weatherResponse = weatherClient.lookup_by_woeid LOCATION_WOEID 

	todayHigh = weatherResponse.forecasts.first['high']
	todayLow = weatherResponse.forecasts.first['low']
	weatherCode = weatherResponse.forecasts.first['code']
	weatherText = weatherResponse.forecasts.first['text']
	tempUnits = "°", weatherResponse.units['temperature']
	tempUnits = tempUnits.join
	speedUnits = weatherResponse.units['speed']

	case weatherCode
		when 0..2
			message = "Holy hell, you better prepare. There are going to be ", weatherText, " today!"
		when 3
			message = "Holy hell, you better prepare. There are going to be ", weatherText, " today!"
		when 4, 37..39, 45, 47
			message = "Don't be afraid when you hear loud bangs today.  It's just ", weatherText, ". Grab an umbrella and wear a raincoat."
		when 5..10, 46
			message = "Overcome adversity as you face the ", weatherText, " out there today. I've prepared you for this day."
		when 11..12, 35, 40
			message = "Might want to grab an umbrella and a raincoat when you head out the door.  There are ", weatherText, " ahead."
		when 13..18, 41..43
			message = "Today, you conquor the ", weatherText ,". Tomorrow, the world. But for today, don't leave home unprepared."
		when 19..22
			message = "Might be a good day to make sure you've got your spare glasses. Poor visibility. It's pretty ", weatherText ,"."
		when 23..25
			message = "Maybe it's warm.  Maybe it's cold.  But it's ", weatherText, " out there today."
		when 26..30, 36, 44
			message = "Don't feel too bad if you spend most of the day indoors.  It's going to be cloudy outside today anyways."
		when 31..34
			message = "Try to get a bit of time outside today.  There aren't too many ", weatherText ," days that you get in this life."
		else
			message = "@ckinniburgh Sir! Sir! I can't seem to see. Do I see? Is that what that sense is? Never mind. The weather. I can't predict it. What's happening, sir?"
	end
	if message.is_a? Array
		message = message.join
	end
	return message
end

def returnWeatherForeTemps()
	weatherClient = Weatherman::Client.new( :unit => WEATHER_UNITS )
	weatherResponse = weatherClient.lookup_by_woeid LOCATION_WOEID 

	todayHigh = weatherResponse.forecasts.first['high']
	todayLow = weatherResponse.forecasts.first['low']
	weatherCode = weatherResponse.forecasts.first['code']
	weatherText = weatherResponse.forecasts.first['text']
	tempUnits = "°", weatherResponse.units['temperature']
	tempUnits = tempUnits.join
	speedUnits = weatherResponse.units['speed']

	case todayHigh
	when -400..0
		message = "Well, it looks like a below zero day today, with a high of ", todayHigh , tempUnits , " and a low of ", todayLow, tempUnits ,"."
	when 0..20
		message =  "Today we're going to be having a high of ", todayHigh , tempUnits , " and a low of ", todayLow, tempUnits ,"."
	when 20..60
		message =  "Looks like a jacket day, today. We're going to be having a high of ", todayHigh , tempUnits , " and a low of ", todayLow, tempUnits ,"."
	when 60..70
		message =  "You can't complain today. There's going to be a high of ", todayHigh , tempUnits , " and a low of ", todayLow, tempUnits ," today."
	when 70..90
		message =  "Nice! I am pleased to announce today will feature a high of ", todayHigh , tempUnits , " and a low of ", todayLow, tempUnits ,"."
	when 90..10000
		message =  "Yikes! It's a warm one.  There's going to be a high of ", todayHigh , tempUnits , " and a low of ", todayLow, tempUnits ," today."
	else
		message = "@ckinniburgh Oh my! I can't seem to feel. Do I feel? Is that what that sense is? Never mind. The temperature. I can't predict it. What's happening, sir?"
	end
	message = message.join
	return message
end