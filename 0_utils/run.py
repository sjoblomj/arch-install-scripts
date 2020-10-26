from cursesmenu import *
from cursesmenu.items import *

menu = CursesMenu("Install Utils?")
item_a = CommandItem("tree", "sudo pacman --needed -S tree")
item_b = CommandItem("git",  "sudo pacman --needed -S git")

menu.append_item(item_a)
menu.append_item(item_b)
menu.show()

