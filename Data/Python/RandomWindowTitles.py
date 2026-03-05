"""
Grabs every open and visible window setting it to a random string of letters for no reason.
"""

import string, win32gui
from time import sleep
from random import choice

def random_string(length):
    letters = string.ascii_letters
    return ''.join(choice(letters) for i in range(length))

def winEnumHandler( hwnd, ctx ):
    if win32gui.IsWindowVisible( hwnd ):
        sleep(0.01)
        win32gui.SetWindowText(hwnd, random_string(20))

if __name__ == "__main__":
    while True:
        win32gui.EnumWindows( winEnumHandler, None )

