from cursesmenu import *
from cursesmenu.items import *
from pathlib import Path
import subprocess

def install_git():
    subprocess.run(['sudo', 'pacman', '-S', '--needed', 'git'])
    subprocess.run(['sudo', 'pacman', '-S', '--needed', 'diff-so-fancy'])
    subprocess.run(['git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"'], shell=True)
    subprocess.run(['git config --global alias.co checkout'], shell=True)
    subprocess.run(['git config --global alias.br branch'], shell=True)
    subprocess.run(['git config --global alias.cp cherry-pick'], shell=True)
    subprocess.run(["git config --global alias.l \"log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(red)- %an%C(reset)%C(bold yellow)%d%C(reset)'\""], shell=True)
    subprocess.run(["git config --global alias.l2 \"log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(red)- %an%C(reset)'\""], shell=True)

    alias_file = str(Path.home()) + '/.zshaliases'
    with open(alias_file, 'a+') as f:
        subprocess.Popen("echo alias gits=\\'git status\\'", stdout=f, stderr=f, shell=True)

    print("Enter name (to use globally for git)")
    name = input()
    print("Enter email (to use globally for git)")
    email = input()
    subprocess.run(["git config --global user.name  \"" + name  + "\""], shell=True)
    subprocess.run(["git config --global user.email \"" + email + "\""], shell=True)


def initial_menu():
    menu = SelectionMenu(["Yes", "No"], "Install git and utils?", "Will install git, diff-so-fancy, create aliases and set name and email for user", False)
    menu.show()
    if menu.selected_option == 0:
        menu.exit()
        install_git()

initial_menu()

