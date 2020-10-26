from cursesmenu import *
from cursesmenu.items import *
from pathlib import Path
import subprocess

def install_slack():
    home = str(Path.home())
    subprocess.run(['sudo', 'pacman', '--needed', '-S', 'git', 'base-devel'])
    subprocess.run(['mkdir', '-p', home + '/bin'])
    subprocess.run(['git', 'clone', 'https://aur.archlinux.org/slack-desktop.git'], cwd=(home + '/bin'))
    subprocess.run(['makepkg', '-sir'], cwd=(home+'/bin/slack-desktop'))

def initial_menu():
    menu = SelectionMenu(["Yes, install Slack"], "Install Slack (chat program)?")
    menu.show()
    if menu.selected_option == 0:
        menu.exit()
        install_slack()

initial_menu()

