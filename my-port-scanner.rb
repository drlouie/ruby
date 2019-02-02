#!/usr/bin/env ruby

#- Load the Socket class, providing access to system's network
require 'socket'

#- Take note of the time we start processing this user request
startProcess = Time.now

#- Set a timeout of two seconds for each port scan call
TIMEOUT = 2

#- Define the portscan method
def portscan(port, host)
	#- Prepare the socket for a connection
	connection      = Socket.new(:INET, :STREAM)
	#- Prepare the connection for host : port(currentPort) query
	remote_address = Socket.sockaddr_in(port, host)

	#- Begin connection routine
	begin
		#- Attempt connection
		connection.connect_nonblock(remote_address)
	#- Failsafe triggered
	rescue 
		#- Error in Progresss
		Errno::EINPROGRESS
	#- End connection routine
	end
	
	#- Attain the connection attempt's state
	_, connected, _ = IO.select(nil, [connection], nil, TIMEOUT)

	#- Connection was successful, port was open
	if connected
		#- Let user know port was open
		puts "Port #{port} is open."
	#- Else connection was unsuccessful, port was closed to connections
	else
		#- Do nothing
	#- End connection state routine
	end
	
#- End portscan method
end

#- Range of ports to scan, default set to 1..443, in essence 1 to 443
portsToScan=*(1..443)

#- Thread stacking array
threadStack = []

#- Request user host input
puts "\nEnter a host to start scanning:"
puts "\n"

#- Assign user host input to variable
userInputHost = gets.strip

#- If userInputHost variable is empty set it to localhost
if userInputHost.empty?
	#- Default is 127.0.0.1 which is usually the proper setting for local network host address
	userInputHost = '127.0.0.1'
#- End userInputHost variable routine
end

#- Let user know scanning has started
puts "\nScanning of #{userInputHost} started."
puts "\n"

#- For each item in portsToScan we run a threaded portscan
portsToScan.each { |currentPort| threadStack << Thread.new { portscan(currentPort, userInputHost) } }

#- Stack each thread
threadStack.each(&:join)

#- Take note of the time we end processing this user request
endProcess = Time.now

#- Find how long it took to finish this request, by subtracting the startProcess time from the endProcess time
timeDifference = Integer(endProcess - startProcess)

#- Let user know how long it took to finish their request
puts "\nScanning of #{userInputHost} completed in #{timeDifference} seconds"
puts "\n"
