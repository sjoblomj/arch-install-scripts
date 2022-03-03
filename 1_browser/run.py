from cursesmenu import *
from cursesmenu.items import *
from shutil import which
import subprocess

def install(program):
    subprocess.run(['sudo', 'pacman', '-S', '--needed', program])

def is_not_installed(program):
    return which(program) is None

def menu_fun():
    lst = ["firefox", "chromium", "torbrowser-launcher"]
    lst = list(filter(lambda x: is_not_installed(x), lst))
    if len(lst) > 0:
        menu = SelectionMenu(lst, "Install Browsers?")
        menu.show()
        menu.exit()
        if menu.selected_option < len(lst):
            install(lst[menu.selected_option])
            menu_fun()
    return()

menu_fun()

