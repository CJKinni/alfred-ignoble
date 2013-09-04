
UserSubj = ["me", "us"]

def AlIgNatLangDemandTell(message, sender_name)
	
	if UserSubj.include? message.split(' ')[2] 
		request = message.split(message.split(' ')[2])[1]
	else
		request = message.split(message.split(' ')[1])[1]
	end
	
	request = request.strip
	
	case request
		when "the time"
			AlIgNatLangRespondTime(request, sender_name)
		when "what time"
			AlIgNatLangRespondTime(request, sender_name)
		else
			return 0
	end
end

