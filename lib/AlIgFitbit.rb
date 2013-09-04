require 'fitgem'
require 'yaml'

#######################################################################
#
#	Fitbit Library for AlfredIgnoble
#
#	Functions:
#	returnFitYesterdaySteps()
#		Return a comment on your daily steps and distance for yesterday
#
#######################################################################

def setupFitbit()

	config = begin
	  Fitgem::Client.symbolize_keys(YAML.load(File.open("./config.yml")))
	rescue ArgumentError => e
	  puts "Could not parse YAML: #{e.message}"
	  exit
	end
 
	client = Fitgem::Client.new(config[:fitgem][:oauth])
	return client
end

def returnFitYesterdaySteps()
	client = setupFitbit()
	
	fitGoalSteps = client.goals["goals"]["steps"]

	distance = client.activities_on_date('yesterday')["summary"]["distances"].first["distance"]
	steps = client.activities_on_date('yesterday')["summary"]["steps"]

	case steps
	when 0..(fitGoalSteps/10)
		message = "For your sake, @ckinniburgh, I hope the fitbit failed to log your steps. Only ", steps , " steps, for a total of " , distance , " miles."
	when (fitGoalSteps/10)..(fitGoalSteps/2)
		message = "Make sure you get an hour of exercise in today, @ckinniburgh. Yesterday you were slacking. Only ", steps , " steps, for a total of " , distance , " miles."
	when (fitGoalSteps/2)..(fitGoalSteps-(fitGoalSteps/5))
		message = "You need to add at least a half hour of exercise today, @ckinniburgh. Yesterday you took it easy. ", steps , " steps, for a total of " , distance , " miles."
	when (fitGoalSteps-(fitGoalSteps/5))..(fitGoalSteps-1)
		message = "You did alright yesterday, @ckinniburgh, but you were so close to your goal. You reached ", steps , " steps, for a total of " , distance , " miles."
	when fitGoalSteps
		message = "Goal. On the nose. @ckinniburgh, That's the way I want you to act everyday. You went ", steps , " steps, for a total of " , distance , " miles."
	when (fitGoalSteps+1)..(fitGoalSteps*1.25)
		message = "You did good yesterday, @ckinniburgh, you hit your goal! You hit ", steps , " steps, for a total of " , distance , " miles."
	when (fitGoalSteps*1.25)..10000000
		message = "Boom. @ckinniburgh knocked it out of the park.  That's what I like to see!  You moved ", steps , " steps, for a total of " , distance , " miles."
	else 
		message = "@ckinniburgh Excuse me, but I seem to have no idea how much activity you got yesterday. I think I might be broken. Please fix me."
	end
	
	message = message.join
	return message 
end

def returnFitWeightChange()
	client = setupFitbit()
	
	config = YAML.load(File.open("./config.yml"))	
	prev_weight = config[:fitbit][:weight]	
	
	current_weight = client.body_measurements_on_date('today')["body"]["weight"]
	
	mesasge = ""
	
	if current_weight < prev_weight-1.5
		message = ADMIN_TWITTER_ACCOUNT + " Good job on that weight loss. Keep it up!"
		config[:fitbit][:weight] = current_weight
		File.open("./config.yml", "w") {|f| f.write(config.to_yaml) }
	elsif current_weight > prev_weight+1.5
		message = "Hey, " + ADMIN_TWITTER_ACCOUNT + " you might want to check how you're eating and exercising. Your weight seems to be increasing."
		config[:fitbit][:weight] = current_weight
		File.open("./config.yml", "w") {|f| f.write(config.to_yaml) }
	end
	
	return message
end
	
		
		