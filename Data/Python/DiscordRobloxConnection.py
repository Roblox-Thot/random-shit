'''
Python script to host a site to allow mass authenticating Roblox accounts for Discord.
Recommended method is to use ic3w0lf22/Roblox-Account-Manager and click the "Open URL" with "http://127.0.0.1/"
'''

from flask import Flask
import requests

TOKEN = input("Discord Token: ")
app = Flask(__name__)

@app.route("/")
def hello_world():
    try:
        href = requests.get('https://canary.discord.com/api/v9/connections/roblox/authorize',
                            headers={'authorization':TOKEN}).json()['url'] # Get the auth url 
        return f'<script>document.location.{href=}</script>'
    except Exception:
        return f'<script>alert("Failed to get auth url, try waiting then refresh")</script>'

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
