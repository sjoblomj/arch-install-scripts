from cursesmenu import *
from cursesmenu.items import *
from shutil import which
import subprocess
import os

programs = {
  "bat": "cat clone with wings",
  "tree": "Draws recursive file tree",
  "ranger": "Terminal file manager",
  "thunar": "GUI file manager",
  "evince": "PDF-viewer",
  "chromium": "Web browser",
  "unzip": "Unzips files",
  "task": "Task manager"
}

def install(program):
    subprocess.run(['sudo', 'pacman', '-S', '--needed', program])

def get_programs_not_installed():
    def is_not_installed(program):
        return which(program) is None
    return list(filter(is_not_installed, programs))

def menu_fun():
    os.system('cls' if os.name == 'nt' else 'clear')

    programs_not_installed = get_programs_not_installed()
    def add_desc(program):
        return program + ":  " + programs[program]

    progs = map(add_desc, programs_not_installed)
    if len(programs_not_installed) > 0:
        menu = SelectionMenu(progs, "Install programs?")
        menu.show()
        menu.exit()
        if menu.selected_option < len(programs_not_installed):
            install(programs_not_installed[menu.selected_option])
            menu_fun()
    quit()

menu_fun()
