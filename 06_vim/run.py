from cursesmenu import *
from cursesmenu.items import *
import subprocess

def install_vimrc():
    subprocess.run(['sh', '-c', '06_vim/vimrc.sh'])


def initial_menu():
    items = list()
    items.append("Install and configure vimrc (Tweaked vim)")

    menu = SelectionMenu(items, "Install vimrc?")
    menu.show()
    menu.exit()
    if menu.selected_option < len(items):
        install_vimrc()

initial_menu()
