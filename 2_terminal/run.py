from cursesmenu import *
from cursesmenu.items import *
from pathlib import Path
import subprocess

def install_terminator():
    subprocess.run(['sudo', 'pacman', '--needed', '-S', 'terminator'])
    config = """[profiles]
  [[default]]
    cursor_blink = False
    scrollback_lines = 50000
"""
    with open(str(Path.home()) + '/.config/terminator/config', 'w+') as f:
        subprocess.Popen("echo '" + config + "'", stdout=f, stderr=f, shell=True)

def initial_menu():
    menu = SelectionMenu(["Yes, run  sudo pacman --needed -S terminator"], "Install Terminator (terminal)?")
    menu.show()
    if menu.selected_option == 0:
        menu.exit()
        install_terminator()

initial_menu()

