'''
Watches a Roblox avatar and
sends a webhook when ever it's updated
'''
from requests import session, exceptions
from time import sleep
requests = session()

UID:int = 4961681370
PRINT:bool = True
WEBHOOK:str = ''
DELAY:float = 2

def send_webhook(n,o) -> None:
    avatar_img = requests.get("https://www.roblox.com/avatar-thumbnails?params=[{userId:"+str(UID)+"}]").json()[0]['thumbnailUrl'].replace('AvatarHeadshot', 'Avatar').replace('60/60', '720/720')

    embed_data = {
        'title': 'Avatar changed',
        'url': f'https://www.roblox.com/users/{UID}/profile',
        'image': {'url': avatar_img},
        'fields': [
            {'name': 'New assets', 'value': f'{n}'},
            {'name': 'Removed assets', 'value': f'{o}'}
        ],
        'color': '16777215'
    }

    payload = {'embeds': [embed_data]}

    requests.post(WEBHOOK, json=payload)

def compare_list(new,old) -> tuple:
    """
    Compare two lists and return new items present in new but not in old,
    and items present in old but not in new.

    Args:
        new (list): The new list.
        old (list): The old list.

    Returns:
        tuple: A tuple containing two lists - new items and removed items.
    """

    set1 = set(new)
    set2 = set(old)
    
    new_items = list(set1 - set2)
    removed_items = list(set2 - set1)
    
    return new_items, removed_items

holder:dict = requests.get(f'https://avatar.roblox.com/v1/users/{UID}/currently-wearing').json()['assetIds']
while True:
    sleep(DELAY)
    try:
        req = requests.get(f'https://avatar.roblox.com/v1/users/{UID}/currently-wearing')
        req.raise_for_status()
        data = req.json()['assetIds']
        if data != holder:
            n,r = compare_list(data,holder)
            if PRINT: print(f'New assets: {n}')
            holder = data
            if WEBHOOK != '': send_webhook(n,r)

    except Exception as e:
        if PRINT: print(e)
