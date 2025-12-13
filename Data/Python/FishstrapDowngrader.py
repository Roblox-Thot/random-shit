import requests

FISHSTRAP_APP = __import__('os').path.expandvars('%LOCALAPPDATA%/Fishstrap/Fishstrap.exe')

def Print(msg):
    print(f'[Fishstrap Updater] {msg}')

def get_roversion(rotype = 'current'):
    # TODO: Rewrite as urllib.request that way requests doesn't need installed (who tf doeeve reve requests)
    url = f'https://inject.today/api/versions/{rotype}'
    response = requests.get(url).json()
    return response['Windows']['Version']

current_version = get_roversion('current')
previous_version = get_roversion('previous')

print('------------------------')
Print(f'Current Version: {current_version}')
Print(f'Previous Version: {previous_version}')
print()

print('1. Update to Current')
print('2. Rollback to Previous')
print('3. Custom version')
user_input = input('> ')

set_to_version = previous_version if user_input.strip() == '2' else current_version

if user_input.strip() == '3':
    custom_version = input('Enter custom version: ')
    set_to_version = custom_version.strip()

__import__('subprocess').Popen([FISHSTRAP_APP, str(set_to_version)])
