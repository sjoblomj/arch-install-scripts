# TODO: Present user with bash-friendly options

sudo pacman-key --init
sudo pacman-key --populate archlinux

sudo pacman -Suy
sudo pacman -S --needed git python-pip
pip install curses-menu

mkdir -p ~/code/arch-install-scripts
git clone https://github.com/sjoblomj/arch-install-scripts ~/code/arch-install-scripts
cd ~/code/arch-install-scripts

python find_scripts.py
