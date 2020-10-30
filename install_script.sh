# TODO: Present user with bash-friendly options

sudo pacman -Suy
sudo pacman -S python-pip git
pip install curses-menu

mkdir -p ~/tools
git clone https://github.com/sjoblomj/arch-install-scripts ~/tools
cd ~/tools/arch-install-scripts

python find_scripts.py
