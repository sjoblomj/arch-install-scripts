from cursesmenu import *
from cursesmenu.items import *
from pathlib import Path
from shutil import which
import subprocess

has_run_keybindings = False
has_run_resolution  = False
resolution_program = "xfce4-display-settings"

def openbox_config_file_exists():
    global has_run_keybindings
    file = Path(str(Path.home()) + "/.config/openbox/rc.xml")
    return file.is_file() and not has_run_keybindings

def resolution_config_file_exists():
    global has_run_resolution
    return which(resolution_program) is not None and not has_run_resolution

def add_keybindings():
    subprocess.run(['sh', '-c', '00_config/add_keybindings.sh'])

def change_resolution():
    subprocess.run([resolution_program])


def menu_fun():
    global has_run_keybindings
    global has_run_resolution
    lst = []
    if openbox_config_file_exists():
        lst.append("Add keybindings to ~/.config/openbox/rc.xml  (Will cause screen to flicker)")
    if resolution_config_file_exists():
        lst.append("Change resolution  (Open " + resolution_program + ")")

    if len(lst) > 0:
        menu = SelectionMenu(lst, "Update system configuration?")
        menu.show()
        menu.exit()
        if menu.selected_option < len(lst):
            if "keybindings"  in lst[menu.selected_option]:
                add_keybindings()
                has_run_keybindings = True
            elif "resolution" in lst[menu.selected_option]:
                change_resolution()
                has_run_resolution  = True
            menu_fun()

menu_fun()

