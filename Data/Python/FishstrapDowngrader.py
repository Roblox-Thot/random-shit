import requests

FISHSTRAP_APP = __import__('os').path.expandvars('%LOCALAPPDATA%/Fishstrap/Fishstrap.exe')

def Print(msg):
    print(f'[Fishstrap Updater] {msg}')

def get_roversion(rotype = 'current'):
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
user_input = input('> ')
rollback = previous_version if user_input.strip() == '2' else current_version
__import__('subprocess').Popen([FISHSTRAP_APP, str(current_version)])
