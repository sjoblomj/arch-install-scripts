from cursesmenu import *
from cursesmenu.items import *

menu = CursesMenu("Install browser?")
item_firefox  = CommandItem("Firefox       sudo pacman --needed -S firefox",  "sudo pacman --needed -S firefox")
item_chromium = CommandItem("Chromium      sudo pacman --needed -S chromium", "sudo pacman --needed -S chromium")
item_tor      = CommandItem("Tor Browser   sudo pacman --needed -S tor",      "sudo pacman --needed -S tor")

menu.append_item(item_firefox)
menu.append_item(item_chromium)
menu.append_item(item_tor)
menu.add_exit()
menu.show()

