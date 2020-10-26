# Import the necessary packages
from os import walk


dirs = []
for (_, dirnames, _) in walk('.'):
    dirs.extend(dirnames)

for directory in sorted(dirs):
    exec(open(directory + '/run.py').read())
