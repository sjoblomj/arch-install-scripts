from cursesmenu import *
from cursesmenu.items import *
from pathlib import Path
import subprocess

has_run_keybindings = False
has_run_resolution  = False

def openbox_config_file_exists():
    file = Path(str(Path.home()) + "/.config/openbox/rc.xml")
    return file.is_file() and not has_run_keybindings

def resolution_config_file_exists():
    file = Path(str(Path.home()) + "/.config/xfce4/xfconf/xfce-perchannel-xml/displays.xml")
    return file.is_file() and not has_run_resolution

def add_keybindings():
    subprocess.run(['sh', '-c', '9_config/add_keybindings.sh'])

def change_resolution():
    subprocess.run(['sh', '-c', '9_config/change_resolution.sh'])


def menu_fun():
    lst = []
    if openbox_config_file_exists():
        lst.append("Add keybindings to ~/.config/openbox/rc.xml  (Will cause screen to flicker)")
    if resolution_config_file_exists():
        lst.append("Change resolution in ~/.config/xfce4/xfconf/xfce-perchannel-xml/displays.xml  (Reboot needed to take effect)"))

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

