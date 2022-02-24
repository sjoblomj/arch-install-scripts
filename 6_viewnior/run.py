from cursesmenu import *
from cursesmenu.items import *
from pathlib import Path
import subprocess

def install_viewnior():
    home = str(Path.home())
    subprocess.run(['sudo', 'pacman', '--needed', '-S', 'git', 'base-devel', 'meson', 'ninja'])
    subprocess.run(['mkdir', '-p', home + '/code'])
    subprocess.run(['git', 'clone', 'https://github.com/sjoblomj/Viewnior.git'], cwd=(home + '/code'))
    subprocess.run(['meson', '--prefix=/usr', 'builddir'], cwd=(home + '/code/Viewnior'))
    subprocess.run(['ninja'], cwd=(home + '/code/Viewnior/builddir'))
    subprocess.run(['sudo', 'ninja', 'install'], cwd=(home + '/code/Viewnior/builddir'))

def initial_menu():
    menu = SelectionMenu(["Yes, install Viewnior"], "Install Viewnior (image viewer)?")
    menu.show()
    if menu.selected_option == 0:
        menu.exit()
        install_viewnior()

initial_menu()

