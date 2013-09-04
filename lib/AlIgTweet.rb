require 'twitter'
require 'yaml'

#######################################################################
#
#	Twitter Library for AlfredIgnoble
#
#	Functions:
#	sendToTwitter(message)
#		THIS NEEDS ADDITIONAL CALL FOR REPLYING!  [ie, (message, returnid)]
#
#	respondToTwitReplyJoke()
#
#######################################################################

def configureTwitter()
	Twitter.configure do |config|
		config.consumer_key = TWIT_CONSUMER_KEY
		config.consumer_secret = TWIT_CONSUMER_SECRET
		config.oauth_token = TWIT_OAUTH_TOKEN
		config.oauth_token_secret = TWIT_OAUTH_TOKEN_SECRET
	end
end

def sendToTwitter(message)
	if message.class == String
		if message.length > 140
			warning = ADMIN_TWITTER_ACCOUNT, " I'm having a bit of a tweet length issue. See the tweet beginning: '" , message[0..40], ".' Thanks!"
			warning = warning.join # TDTDTD - There must be a better way of merging these. ANSWER: USE '+' instead of ',' to merge.
		
			if OFFLINE_MODE == false && message != nil
				configureTwitter()
				Twitter.update(warning)
			else
				puts warning
			end

		end
	
		if OFFLINE_MODE == false && message != nil
			message = message[0..140]
			configureTwitter()
			Twitter.update(message)
			puts "Tweeting: " + message
		else
			puts message
		end
	end
end

def respondToTwitReplyJoke()
	configureTwitter()
	config = YAML.load(File.open("./config.yml"))
	
	lastid = config[:twitter][:tweetResponder][:lastid]	
	
	mentionTimeline = Twitter.mentions_timeline(:since_id => lastid, :exclude_replies => TRUE)
	unless mentionTimeline.nil?
		mentionTimeline.each do |mention|
			response = "@" , mention[:from_user] , " I generally take a few to respond. Until then, think about this: " , File.readlines("./oneLiners.txt").sample
			response = response.join
			Twitter.update(response, :in_reply_to_status_id => mention[:id])
		end	
	end
	if mentionTimeline == Array
		if mentionTimeline.last[:id] != ''
			config[:twitter][:tweetResponder][:lastid] = lastid
			File.open("./config.yml", "w") {|f| f.write(config.to_yaml) }
		end
	end

end