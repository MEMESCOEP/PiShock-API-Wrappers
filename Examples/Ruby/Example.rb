### LIBRARIES ###
require_relative 'PiShockAPI'

### MAIN CODE ###
begin
    # Initialize the API
    api = PiShockAPI.new("UserName", "DeviceName", "ShareCode", "APIKey")

    # Make sure the hub is online
    if !api.IsHubOnline()
        raise "The hub is not online!"
    end

    # Send a beep and wait for 2 seconds (Duration is 1 second)
    puts "Sending beep..."
    api.SendBeep(1)
    sleep 2

    # Send a vibration and wait for 2 seconds (Intensity is 25, Duration is 1 second)
    puts "Sending vibration..."
    api.SendVibration(25, 1)
    sleep 2
    
    # Send a shock and wait for 2 seconds (Intensity is 5, Duration is 1 second)
    puts "Sending shock..."
    api.SendShock(5, 1)
    sleep 2
    
    # Get the collar info in JSON format
    puts "Getting collar info..."
    puts api.GetCollarInfo().to_s

rescue => error
    puts "[ERROR] >> #{error.message.to_s}"
end
