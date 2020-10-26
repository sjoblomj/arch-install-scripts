from os import walk
from pathlib import Path


dirs = []
for (_, dirnames, _) in walk('.'):
    dirs.extend(dirnames)

for directory in sorted(dirs):
    if Path(directory + '/run.py').is_file():
        exec(open(directory + '/run.py').read())
