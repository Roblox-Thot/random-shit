'''
This is the code that can be used to reactivate a Roblox account after a ban/warn
'''

from bs4 import BeautifulSoup
from requests import session

sus = session()

cookie = "ROBLOX COOKIE"

sus.cookies.update({'.ROBLOSECURITY':cookie})

html_input = sus.get("https://www.roblox.com/not-approved").content # Get warn data

# Get the form data to post
soup = BeautifulSoup(html_input, 'html.parser')
verification_token = soup.find('input', {'name': '__RequestVerificationToken'})['value']
punishmentId = soup.find('input', {'name': 'punishmentId'})['value']

# Post the data
req = sus.post("https://www.roblox.com/not-approved/reactivate", data={'__RequestVerificationToken':verification_token,'punishmentId':punishmentId}, headers={'Content-Type':'application/x-www-form-urlencoded'})
