### PiShock API Wrapper ###
# IMPORTS #
import requests

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
    def SendBeep(self, Duration, Debug = False):
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

        if Debug:
            print("[BEEP] >> JSON data: ", data)
            print("[BEEP] >> Status code: ", Response.status_code)
            print("[BEEP] >> Message: ", Message)

        if Response.content.decode("utf-8") != "Operation Succeeded.":
            raise Exception(Message)
        
        elif Response.status_code != 200:
            raise Exception("POST failed: ", Response.status_code)
        

        
    # Send a vibration with the specified intensity and duration
    def SendVibration(self, Intensity, Duration, Debug = False):
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

        if Debug:
            print("[VIBR] >> JSON data: ", data)
            print("[VIBR] >> Status code: ", Response.status_code)
            print("[VIBR] >> Message: ", Message)

        if Response.content.decode("utf-8") != "Operation Succeeded.":
            raise Exception(Message)
        
        elif Response.status_code != 200:
            raise Exception("POST failed: ", Response.status_code)
        


    # Send a shock with the specified intensity and duration
    def SendShock(self, Intensity, Duration, Debug = False):
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

        if Debug:
            print("[SHCK] >> JSON data: ", data)
            print("[SHCK] >> Status code: ", Response.status_code)
            print("[SHCK] >> Message: ", Message)

        if Response.content.decode("utf-8") != "Operation Succeeded.":
            raise Exception(Message)
        
        elif Response.status_code != 200:
            raise Exception("POST failed: ", Response.status_code)

    # Retrieve information about the collar
    def GetCollarInfo(self, Debug = False):
        data = {
            "Username": self.Username,
            "Code": self.ShareCode,
            "Apikey": self.APIKey,
        }
        Response = requests.post("https://do.pishock.com/api/GetShockerInfo", headers=headers, json=data)
        Message = Response.content.decode("utf-8")

        if Debug:
            print("[INFO] >> JSON data: ", data)
            print("[INFO] >> Status code: ", Response.status_code)
            print("[INFO] >> Message: ", Message)

        if Response.content.decode("utf-8") != "Operation Succeeded.":
            raise Exception(Message)
        
        elif Response.status_code != 200:
            raise Exception("POST failed: ", Response.status_code)
        
