### PiShock API Wrapper ###
# IMPORTS #
import requests, json

# VARIABLES #
# Do not change these!
url = "https://do.pishock.com/api/apioperate"
headers = {"Content-Type": "application/json"}

# CLASSES #
class PiShockAPI:
    # FUNCTIONS #
    # Initialize everything
    def __init__(self, uname, name, code, key):
        self.Username = uname
        self.ComputerName = name
        self.ShareCode = code
        self.APIKey = key
    
    # Send a beep with the specified duration
    def SendBeep(self, Duration):
        if Duration < 1 or Duration > 15:
            raise Exception("Invalid duration! The duration must be between 1 and 15.")

        data = {
            "Username": self.Username,
            "Name": self.ComputerName,
            "Code": self.ShareCode,
            "Duration": str(Duration), 
            "Apikey": self.APIKey,
            "Op": "2",
        }
        Response = requests.post(url, headers=headers, json=data)
        Message = Response.content.decode("utf-8")

        if Response.status_code != 200:
            raise Exception("POST failed: ", Response.status_code)
        
        elif Response.content.decode("utf-8") != "Operation Succeeded.":
            raise Exception(Message)
        


        
    # Send a vibration with the specified intensity and duration
    def SendVibration(self, Intensity, Duration):
        if Intensity < 1 or Intensity > 100:
            raise Exception("Invalid intensity! The intensity must be between 1 and 100.")

        if Duration < 1 or Duration > 15:
            raise Exception("Invalid duration! The duration must be between 1 and 15.")
        
        data = {
            "Username": self.Username,
            "Name": self.ComputerName,
            "Code": self.ShareCode,
            "Intensity": str(Intensity),
            "Duration": str(Duration), 
            "Apikey": self.APIKey,
            "Op": "1",
        }
        Response = requests.post(url, headers=headers, json=data)
        Message = Response.content.decode("utf-8")

        if Response.status_code != 200:
            raise Exception("POST failed: ", Response.status_code)
        
        elif Response.content.decode("utf-8") != "Operation Succeeded.":
            raise Exception(Message)
        


    # Send a shock with the specified intensity and duration
    def SendShock(self, Intensity, Duration):
        if Intensity < 1 or Intensity > 100:
            raise Exception("Invalid intensity! The intensity must be between 1 and 100.")

        if Duration < 1 or Duration > 15:
            raise Exception("Invalid duration! The duration must be between 1 and 15.")
        
        data = {
            "Username": self.Username,
            "Name": self.ComputerName,
            "Code": self.ShareCode,
            "Intensity": str(Intensity),
            "Duration": str(Duration), 
            "Apikey": self.APIKey,
            "Op": "0",
        }
        Response = requests.post(url, headers=headers, json=data)
        Message = Response.content.decode("utf-8")

        if Response.status_code != 200:
            raise Exception("POST failed: ", Response.status_code)
        
        elif Response.content.decode("utf-8") != "Operation Succeeded.":
            raise Exception(Message)

    # Retrieve information about the collar
    def GetCollarInfo(self):
        data = {
            "Username": self.Username,
            "Code": self.ShareCode,
            "Apikey": self.APIKey,
        }
        Response = requests.post("https://do.pishock.com/api/GetShockerInfo", headers=headers, json=data)
        Message = Response.content.decode("utf-8")

        if Response.status_code != 200:
            raise Exception("POST failed: ", Response.status_code)

        return Message

    # See if the hub is online
    def IsHubOnline(self):
        data = {
            "Username": self.Username,
            "Code": self.ShareCode,
            "Apikey": self.APIKey,
        }
        Response = requests.post("https://do.pishock.com/api/GetShockerInfo", headers=headers, json=data)
        Message = Response.content.decode("utf-8")
        JSON = json.loads(Message)

        if Response.status_code != 200:
            raise Exception("POST failed: ", Response.status_code)

        return JSON["online"] != False
