require 'yaml'

#######################################################################
#
#	General Utility Library for AlfredIgnoble
#	
# 	passFuncRand(message, frequency)
#		message is likely a function response.
#
#		frequency is a unit expressed as the number of times 
#		this needs to be run.  ie. f=20 if it's 1 in 20.
#
#	returnCodeThanks()
#		Returns a thank you message when there has been a code update
#		in the past hour.
#
#######################################################################

def passFuncRand(message, frequency)
	
	roll = rand frequency
	
	if roll == 0
		return message
	else
		return nil
	end
end

def passFuncWeekDay(message)
	now = Time.now
	
	if now.wday.between?(1,5) && now.hour.between?(9,17)
		return message
	else
		return nil
	end
end	

def returnCodeThanks()
	Dir["./*"].each do |filename|
		pn = Pathname.new(filename)

		@time       = Time.now
		@reducetime = @time - (CODE_THANKYOU_INTERVAL)

		if pn.mtime.between?(@reducetime, @time)

			output = IO.popen %Q#find . -name '*.*' | xargs wc -l | grep "total"#

			lines = output.readlines.first.chomp.strip

			message = "It gives me such a thrill when ", ADMIN_TWITTER_ACCOUNT ," works on me, like he did today. He's written ", lines, " lines of code to make me what I am."
			message = message.join

			return message
		else
			return nil
		end
		
	end
end