'''
You will need a "catch all" on a domain and forward it to an email you have access to.
You could also edit this to use the + email trick on sites like Gmail and Yahoo.
Just change "DOMAIN" to the domain that it is set up for.

You can verify 10 cookies per IP till you get ratelimited for a while
'''
import requests, secrets, string
from time import sleep

class Shit:
    def __init__(self, cookie:str, host:str):
        self.cookie = cookie
        self.host = host
        self.request = requests.Session()
        self.request.cookies.update({'.ROBLOSECURITY':self.cookie})
        pass

    def email(self): # Random email
        chars = string.ascii_lowercase + string.digits
        user = ''.join(secrets.choice(chars) for _ in range(15))
        return f'{user}@{self.host}'

    def getXsrf(self):
        xsrHeader = self.request.post("https://auth.roblox.com/v2/login", headers={
            "X-CSRF-TOKEN": ""
        }).headers['x-csrf-token']
        return xsrHeader
    
    def emailTH(self):
        data = {"emailAddress":self.email(), "password":""}
        req = self.request.post('https://accountsettings.roblox.com/v1/email',json=data,headers={'x-csrf-token':self.getXsrf()})
        return req

if __name__ == "__main__":
    for i in open('cookies.txt','r').readlines():
        a = Shit(i.strip()
            ,"DOMAIN").emailTH()
        print(a,a.text)
