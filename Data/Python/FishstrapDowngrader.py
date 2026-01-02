import requests

DESIRED_SPLOIT = 'Volt'
FISHSTRAP_APP = __import__('os').path.expandvars('%LOCALAPPDATA%/Fishstrap/Fishstrap.exe')

def Print(msg):
    print(f'[Fishstrap Updater] {msg}')

def get_roversion(rotype = 'current'):
    try:
        url = f'https://inject.today/api/versions/{rotype}'
        response = requests.get(url).json()
        return response['Windows']['Version']
    except Exception as e:
        return (f'Error fetching {rotype} version: {e}')

def get_weao_rover():
    url = f'https://weao.gg/api/status/exploits/{DESIRED_SPLOIT.lower()}'
    response = requests.get(url).json()
    return response['data']['rbxversion']

current_version = get_roversion('current')
previous_version = get_roversion('previous')
exploit_Rversion = get_weao_rover()

print('------------------------')
Print(f'Current Version: {current_version}')
Print(f'Previous Version: {previous_version}')
Print(f'{DESIRED_SPLOIT} Roblox Version: {exploit_Rversion}')
print()

print('1. Update to Current')
print('2. Rollback to Previous')
print(f'3. Update to {DESIRED_SPLOIT} Supported Version')
print('4. Custom version')
user_input = input('> ')


match user_input.strip():
    case '1':
        set_to_version = current_version
    case '2':
        set_to_version = previous_version
    case '3':
        set_to_version = exploit_Rversion
    case '4':
        custom_version = input('Enter custom version: ')
        set_to_version = custom_version.strip()
    case _:
        Print('Invalid option selected. Exiting.')
        exit(1)

__import__('subprocess').Popen([FISHSTRAP_APP, str(set_to_version)])
