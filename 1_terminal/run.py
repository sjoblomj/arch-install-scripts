from cursesmenu import *
from cursesmenu.items import *
from pathlib import Path
import subprocess

def install_ohmyzsh():
    subprocess.run(['sh', '-c', '1_terminal/ohmyzsh.sh'])


def install_terminator():
    subprocess.run(['sudo', 'pacman', '--needed', '-S', 'terminator'])
    config = """[profiles]
  [[default]]
    cursor_blink = False
    scrollback_lines = 50000
"""

    p = Path(str(Path.home()) + '/.config/terminator/')
    p.mkdir(parents=True, exist_ok=True)
    with open(str(Path.home()) + '/.config/terminator/config', 'a+') as f:
        subprocess.Popen("echo '" + config + "'", stdout=f, stderr=f, shell=True)

def initial_menu(show_terminator, show_ohmyzsh):
    items = list()
    if show_terminator:
        items.append("Install and configure Terminator (terminal)")
    if show_ohmyzsh:
        items.append("Install and configure oh-my-zsh (zsh config)")
    if len(items) == 0:
        return()

    menu = SelectionMenu(items, "Install terminal and config?")
    menu.show()
    menu.exit()
    if menu.selected_option < len(items):
        if "Terminator"  in items[menu.selected_option]:
            install_terminator()
            initial_menu(False, show_ohmyzsh)
        elif "oh-my-zsh" in items[menu.selected_option]:
            install_ohmyzsh()
            initial_menu(show_terminator, False)

initial_menu(True, True)
