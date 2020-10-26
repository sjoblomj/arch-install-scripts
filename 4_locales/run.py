from cursesmenu import *
from cursesmenu.items import *
from pathlib import Path
import subprocess

def get_locales():
    locs = subprocess.run(['locale', '-a'], stdout=subprocess.PIPE).stdout.decode("utf-8")
    return list(filter(lambda locale: locale != '', locs.split("\n")))

def add_line_to_file(f, line):
    subprocess.Popen("echo " + line, stdout=f, stderr=f, shell=True)

def configure_gsimplecal(f):
    locales = get_locales()
    menu = SelectionMenu(locales, "You have gsimplecal installed, but have not configured a locale for it. Do you want to do so?", "You have these locales installed: " + str(locales))

    menu.show()
    menu.exit()
    if menu.selected_option < len(locales):
        add_line_to_file(f, "force_lang = " + locales[menu.selected_option])



def add_locales():
    subprocess.run(['sudo', 'vim', '/etc/locale.gen'])
    subprocess.run(['sudo', 'locale-gen'])

    home = str(Path.home())
    gsimplecal = Path(home + '/.config/gsimplecal/config')
    if gsimplecal.is_file():
        with open(home + '/.config/gsimplecal/config', 'a+') as f:
            content = f.read()
            if "force_lang" not in content:
                configure_gsimplecal(f)

def initial_menu():
    locales = get_locales()
    menu = SelectionMenu(["Yes, open /etc/locale.gen in vim", "No"], "Add more locales?", "You have these installed: " + str(locales), False)
    menu.show()
    if menu.selected_option == 0:
        menu.exit()
        add_locales()

initial_menu()

