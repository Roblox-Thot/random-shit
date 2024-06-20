'''
This is the code that can be used to reactivate a Roblox account after a ban/warn
'''
import time
from requests import session

def unwarn(cookie:str):
    requests = session()
    requests.cookies.update({'.ROBLOSECURITY': cookie})
    ban_data = requests.get("https://usermoderation.roblox.com/v1/not-approved")

    while True:
        try:
            if ban_data.status_code != 200: print("Error getting ban data");exit()
            
            ban_data = ban_data.json()
            if len(ban_data) > 0:

                token = requests.post('https://usermoderation.roblox.com/v1/not-approved/reactivate').headers['x-csrf-token'] # Grabs the x-csrf token
                headers = {
                            'content-type': 'application/json',
                            'X-Csrf-Token': token
                        }
                
                punishmentTypeDescription = ban_data["punishmentTypeDescription"]
                print(f'The account has been {punishmentTypeDescription}')
                if punishmentTypeDescription != "Warn": break # TODO: check if the unban date has passed

                attempt = requests.post("https://usermoderation.roblox.com/v1/not-approved/reactivate", headers= headers)
                if attempt.status_code == 200:
                    print("The account has been reactivated") 
                    break

            else:
                print("The account is in good standing")
                break

        except Exception as e:
            print(f"Reactivation error: {e}")
            time.sleep(1)

if __name__ == '__main__':
    cookie = input("Cookie: ")
    unwarn(cookie)
