from cursesmenu import *
from cursesmenu.items import *
from pathlib import Path
import subprocess
import re

maven = "maven"

def get_javas():
    pacman = subprocess.check_output(['pacman', '-Ss', 'java'])
    lst = pacman.decode('utf-8').split("\n")
    lst = list(filter(lambda x: re.search("(jdk|jre)[0-9]*-openjdk ", x) != None, lst))
    lst = list(map(lambda x: x.replace("extra/", "").split(" ", 1)[0], lst))
    lst.append(maven)
    return lst

def install(program):
    subprocess.run(['sudo', 'pacman', '-S', '--needed', program])


def install_maven():
    install(maven)
    add_alias("alias mci=\\'mvn clean install\\'")


def add_line_to_file(f, line):
    subprocess.Popen("echo " + line, stdout=f, stderr=f, shell=True)

def add_alias(alias):
    alias_file = str(Path.home()) + '/.zshaliases'
    with open(alias_file, 'a+') as f:
       add_line_to_file(f, alias)
    zshrc_file = str(Path.home()) + '/.zshrc'
    with open(zshrc_file, 'a+') as f:
        f.seek(0)
        content = f.read()
        source_text = "source ~/.zshaliases"
        if source_text not in content:
            add_line_to_file(f, source_text)

def initial_menu():
    lst = get_javas()
    menu = SelectionMenu(lst, "Install Java?")
    menu.show()

    if menu.selected_option < len(lst):
        program = lst[menu.selected_option]
        if program == maven:
            install_maven()
        else:
            install(program)
        initial_menu()
    return()

initial_menu()

