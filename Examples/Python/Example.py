### LIBRARIES ###
import PiShockAPI
import time

### MAIN CODE ###
try:
    # Initialize the API
    api = PiShockAPI.PiShockAPI("Username", "DeviceName", "ShareCode", "APIKey")

    # Test to see if the hub is online
    if not api.IsHubOnline():
        raise Exception("The hub is not online!")

    # Send a beep and wait 2 seconds (Duration is 1 second)
    print("Sending beep...")
    api.SendBeep(1)
    time.sleep(2)

    # Send a vibration and wait 2 seconds (Intensity is 25, Duration is 1 second)
    print("Sending vibration...")
    api.SendVibration(25, 1)
    time.sleep(2)

    # Send a shock and wait 2 seconds (Intensity is 5, Duration is 1 second)
    print("Sending shock...")
    api.SendShock(5, 1)
    time.sleep(2)

    # Get the collar info in JSON format
    print("Getting collar info...")
    print("Collar info: ", api.GetCollarInfo())

except Exception as ex:
    print("[ERROR] >> ", ex)
