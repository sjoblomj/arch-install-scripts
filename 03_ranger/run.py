from cursesmenu import *
from cursesmenu.items import *
from pathlib import Path
from shutil import which
import subprocess

def install_ranger():
    subprocess.run(['sh', '-c', '03_ranger/ranger.sh'])


def menu_fun():
    if which("ranger") is None:
        menu = SelectionMenu(["Yes, install ranger"], "Install ranger (console file manager)?")
        menu.show()
        if menu.selected_option == 0:
            menu.exit()
            install_ranger()

menu_fun()

