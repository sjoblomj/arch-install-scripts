from cursesmenu import *
from cursesmenu.items import *
from pathlib import Path
import getpass
import subprocess

def add_line_to_file(f, line):
    subprocess.Popen("echo " + line, stdout=f, stderr=f, shell=True)

def add_alias(alias):
    home = str(Path.home())
    alias_file = home + '/.zshaliases'
    with open(alias_file, 'a+') as f:
       add_line_to_file(f, alias)
    zshrc_file = home + '/.zshrc'
    with open(zshrc_file, 'a+') as f:
        f.seek(0)
        content = f.read()
        source_text = "source " + alias_file
        if source_text not in content:
            add_line_to_file(f, source_text)


def install_docker():
    current_user = getpass.getuser()
    subprocess.run(['sudo', 'pacman', '-S', '--needed', 'docker', 'docker-compose'])
    subprocess.run(['sudo', 'systemctl', 'start', 'docker.service'])
    subprocess.run(['sudo', 'systemctl', 'enable', 'docker.service'])
    subprocess.run(['sudo', 'usermod', '-aG', 'docker', current_user])
    add_alias("alias dc=\\'docker-compose\\'")
    add_alias("alias clean-docker=\\'if \[\[ \$\(docker ps -qa\) \]\]\; then docker stop \$\(docker ps -qa\) \; docker rm \$\(docker ps -qa\) \; fi\; if \[\[ \$\(docker volume ls -qf dangling=true\) \]\]\; then docker volume rm \$\(docker volume ls -qf dangling=true\)\; fi\\'")

def initial_menu():
    items = list()
    items.append("Install Docker and Docker Compose")

    menu = SelectionMenu(items, "Install and configure Docker and Docker Compose?")
    menu.show()
    menu.exit()
    if menu.selected_option < len(items):
        install_docker()

initial_menu()
