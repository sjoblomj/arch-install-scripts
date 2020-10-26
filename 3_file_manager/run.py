from cursesmenu import *
from cursesmenu.items import *

menu = CursesMenu("Install file manager?")
item_ranger = CommandItem("ranger    sudo pacman --needed -S ranger", "sudo pacman --needed -S ranger")
item_thunar = CommandItem("thunar    sudo pacman --needed -S thunar", "sudo pacman --needed -S thunar")

menu.append_item(item_ranger)
menu.append_item(item_thunar)
menu.add_exit()
menu.show()

