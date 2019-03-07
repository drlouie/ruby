#!/usr/bin/env ruby

#- Load the Whois class
require 'whois'

#- Take note of the time we start processing this user request
startProcess = Time.now

#- Define the whoisQuery method
def whoisQuery(domain)

	#- Begin routine
	begin
		#- Attempt 
		r = Whois.whois(domain)
	#- Failsafe triggered
	rescue 
		#- Silence: Nothing to do
	#- End routine
	end
	
	#- Connection was successful, port was open
	if r
		#- Let user know port was open
		puts r
	#- End connection state routine
	end
	
#- End whoisQuery method
end

#- Request user domain input
puts "\nEnter domain name to run a WHOIS query upon:"
puts "\n"

#- Assign user domain input to variable
userInputDomain = gets.strip

#- Let user know querying has started
puts "\Query for #{userInputDomain} started."
puts "\n"

#- Run a whoisQuery on userInputDomain
whoisQuery(userInputDomain)

#- Take note of the time we end processing this user request
endProcess = Time.now

#- Find how long it took to finish this request, by subtracting the startProcess time from the endProcess time
timeDifference = Integer(endProcess - startProcess)

#- Let user know how long it took to finish their request
puts "\Query for #{userInputDomain} completed in #{timeDifference} seconds"
puts "\n"
