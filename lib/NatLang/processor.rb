

def AlIgNatLangProcessor(message, sender_name)
	# Takes twitter message directed @AlfredIgnoble as message.
	check_verb = message.split(' ')[1]

	case check_verb
	when "tell"
		AlIgNatLangDemandTell(message, sender_name)
	end

end