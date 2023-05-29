### PiShock API Wrapper ###
# REQUIRED LIBRARIES #
require "json"
require "faraday"

# CLASSES #
class PiShockAPI
    # FUNCTIONS #
    # Initialize everything
    def initialize(uname, name, code, key)
        @url = "https://do.pishock.com/api/apioperate"
        @username = uname
        @computerName = name
        @shareCode = code
        @apiKey = key
    end

    # Send a beep with the specified duration
    def SendBeep (duration = 1)    
        if duration < 1 or duration > 15
            raise "Invalid duration! The duration must be between 1 and 15."
        end

        data = {
            "Username": @username,
            "Name": @computerName,
            "Code": @shareCode,
            "Duration": duration,
            "Apikey": @apiKey,
            "Op": "2"
        }.to_json

        r = Faraday.post(@url, data, 'Content-Type'=>'application/json')

        if r.status != 200
            raise "POST failed: #{r.status}"
        elsif r.body != "Operation Succeeded."
            raise r.body
        end
    end

    # Send a vibration with the specified intensity and duration
    def SendVibration (intensity = 1, duration = 1)    
        if duration < 1 or duration > 15
            raise "Invalid duration! The duration must be between 1 and 15."
        end

        if intensity < 1 or intensity > 100
            raise "Invalid intensity! The intensity must be between 1 and 100."
        end

        data = {
            "Username": @username,
            "Name": @computerName,
            "Code": @shareCode,
            "Intensity": intensity,
            "Duration": duration,
            "Apikey": @apiKey,
            "Op": "1"
        }.to_json

        r = Faraday.post(@url, data, 'Content-Type'=>'application/json')

        if r.status != 200
            raise "POST failed: #{r.status}"
        elsif r.body != "Operation Succeeded."
            raise r.body
        end
    end

    # Send a shock with the specified intensity and duration
    def SendShock (intensity = 1, duration = 1)    
        if duration < 1 or duration > 15
            raise "Invalid duration! The duration must be between 1 and 15."
        end

        if intensity < 1 or intensity > 100
            raise "Invalid intensity! The intensity must be between 1 and 100."
        end

        data = {
            "Username": @username,
            "Name": @computerName,
            "Code": @shareCode,
            "Intensity": intensity,
            "Duration": duration,
            "Apikey": @apiKey,
            "Op": "0"
        }.to_json

        r = Faraday.post(@url, data, 'Content-Type'=>'application/json')

        if r.status != 200
            raise "POST failed: #{r.status}"
        elsif r.body != "Operation Succeeded."
            raise r.body
        end
    end

    # Send a shock with the specified intensity and duration of 300 milliseconds
    def SendMiniShock (intensity = 1)
        if intensity < 1 or intensity > 100
            raise "Invalid intensity! The intensity must be between 1 and 100."
        end

        data = {
            "Username": @username,
            "Name": @computerName,
            "Code": @shareCode,
            "Intensity": intensity,
            "Duration": 300,
            "Apikey": @apiKey,
            "Op": "0"
        }.to_json

        r = Faraday.post(@url, data, 'Content-Type'=>'application/json')

        if r.status != 200
            raise "POST failed: #{r.status}"
        elsif r.body != "Operation Succeeded."
            raise r.body
        end
    end

    # Retrieve information about the collar
    def GetCollarInfo()
        data = {
            "Username": @username,
            "Code": @shareCode,
            "Apikey": @apiKey,
        }.to_json

        r = Faraday.post("https://do.pishock.com/api/GetShockerInfo", data, 'Content-Type'=>'application/json')

        if r.status != 200
            raise "POST failed: #{r.status}"
        end

        return r.body
    end

    # See if the hub is online
    def IsHubOnline()
        data = {
            "Username": @username,
            "Code": @shareCode,
            "Apikey": @apiKey,
        }.to_json

        r = Faraday.post("https://do.pishock.com/api/GetShockerInfo", data, 'Content-Type'=>'application/json')
        jsonData = JSON.parse(r.body)

        if r.status != 200
            raise "POST failed: #{r.status}"
        end

        return (jsonData['online'] != false)
    end

    # See if the collar is paused
    def IsCollarPaused()
        data = {
            "Username": @username,
            "Code": @shareCode,
            "Apikey": @apiKey,
        }.to_json

        r = Faraday.post("https://do.pishock.com/api/GetShockerInfo", data, 'Content-Type'=>'application/json')
        jsonData = JSON.parse(r.body)

        if r.status != 200
            raise "POST failed: #{r.status}"
        end

        return (jsonData['paused'] == false)
    end

    # Get the collar's name
    def GetCollarName()
        data = {
            "Username": @username,
            "Code": @shareCode,
            "Apikey": @apiKey,
        }.to_json

        r = Faraday.post("https://do.pishock.com/api/GetShockerInfo", data, 'Content-Type'=>'application/json')
        jsonData = JSON.parse(r.body)

        if r.status != 200
            raise "POST failed: #{r.status}"
        end

        return (jsonData['name'])
    end

    # Get the collar's client ID
    def GetCollarClientID()
        data = {
            "Username": @username,
            "Code": @shareCode,
            "Apikey": @apiKey,
        }.to_json

        r = Faraday.post("https://do.pishock.com/api/GetShockerInfo", data, 'Content-Type'=>'application/json')
        jsonData = JSON.parse(r.body)

        if r.status != 200
            raise "POST failed: #{r.status}"
        end

        return (jsonData['clientId'])
    end

    # Get the collar's ID
    def GetCollarID()
        data = {
            "Username": @username,
            "Code": @shareCode,
            "Apikey": @apiKey,
        }.to_json

        r = Faraday.post("https://do.pishock.com/api/GetShockerInfo", data, 'Content-Type'=>'application/json')
        jsonData = JSON.parse(r.body)

        if r.status != 200
            raise "POST failed: #{r.status}"
        end

        return (jsonData['id'])
    end

    # Get the collar's maximum intensity
    def GetCollarMaxIntensity()
        data = {
            "Username": @username,
            "Code": @shareCode,
            "Apikey": @apiKey,
        }.to_json

        r = Faraday.post("https://do.pishock.com/api/GetShockerInfo", data, 'Content-Type'=>'application/json')
        jsonData = JSON.parse(r.body)

        if r.status != 200
            raise "POST failed: #{r.status}"
        end

        return (jsonData['maxIntensity'])
    end

    # Get the collar's maximum duration
    def GetCollarMaxDuration()
        data = {
            "Username": @username,
            "Code": @shareCode,
            "Apikey": @apiKey,
        }.to_json

        r = Faraday.post("https://do.pishock.com/api/GetShockerInfo", data, 'Content-Type'=>'application/json')
        jsonData = JSON.parse(r.body)

        if r.status != 200
            raise "POST failed: #{r.status}"
        end

        return (jsonData['maxDuration'])
    end
end
