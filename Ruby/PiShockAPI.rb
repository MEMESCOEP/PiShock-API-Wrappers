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
    def SendBeep (duration = 1, debug = false)    
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

        if debug
            puts "[BEEP] >> JSON data: #{data}"
            puts "[BEEP] >> Status code: #{r.status}"
            puts "[BEEP] >> Message: #{r.body}"
        end

        if r.body != "Operation Succeeded."
            raise r.body
        elsif r.status != 200
            raise "POST failed: #{r.status}"
        end
    end

    # Send a vibration with the specified intensity and duration
    def SendVibration (intensity = 1, duration = 1, debug = false)    
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

        if debug
            puts "[VIBR] >> JSON data: #{data}"
            puts "[VIBR] >> Status code: #{r.status}"
            puts "[VIBR] >> Message: #{r.body}"
        end

        if r.body != "Operation Succeeded."
            raise r.body
        elsif r.status != 200
            raise "POST failed: #{r.status}"
        end
    end

    # Send a shock with the specified intensity and duration
    def SendShock (intensity = 1, duration = 1, debug = false)    
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

        if debug
            puts "[SHCK] >> JSON data: #{data}"
            puts "[SHCK] >> Status code: #{r.status}"
            puts "[SHCK] >> Message: #{r.body}"
        end

        if r.body != "Operation Succeeded."
            raise r.body
        elsif r.status != 200
            raise "POST failed: #{r.status}"
        end
    end

    # Retrieve information about the collar
    def GetCollarInfo(debug = false)
        data = {
            "Username": @username,
            "Code": @shareCode,
            "Apikey": @apiKey,
        }.to_json

        r = Faraday.post("https://do.pishock.com/api/GetShockerInfo", data, 'Content-Type'=>'application/json')

        if debug
            puts "[INFO] >> JSON data: #{data}"
            puts "[INFO] >> Status code: #{r.status}"
            puts "[INFO] >> Message: #{r.body}"
        end

        if r.body != "Operation Succeeded."
            raise r.body
        elsif r.status != 200
            raise "POST failed: #{r.status}"
        end
    end
end
