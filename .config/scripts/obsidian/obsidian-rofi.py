#!/bin/python

import json
import sys
import os
#import urllib
import subprocess
from urllib.parse import quote
import logging

# Usage examples:
#   rofi -modi "obsidian:./obsidian-rofi.py" -show obsidian
#   rofi -modes combi -show combi -show-icons -combi-modes "window,obsidian:./obsidian-rofi.py"
#   rofi -modes "window,obsidian" -show window -show-icons -modi "window,obsidian:./obsidian-rofi.py"

# Set these two variables with your personal settings
vault_name = 'happyhouse'
vault_path = '/home/svonjoi/dev/repo/happyhouse'
logging.basicConfig(filename='obsidian-rofi.log', encoding='utf-8', level=logging.DEBUG)


if 'ROFI_INFO' in os.environ:
    mid = os.environ['ROFI_INFO']
    #name = urllib.parse.quote(vault_name)
    name = quote(vault_name)
    uri = f'obsidian://switch?vault={name}&id={mid}'

    logging.info(uri)

    subprocess.call(["xdg-open", uri], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    sys.exit(0)

def leaf_indexes(data, indexes=None, depth=0):
    indexes = indexes or []
    if depth > 50:
        raise RecursionError
    if isinstance(data, dict):
        if data.get('type') == 'leaf':
            if data['state']['type'] in ['markdown', 'canvas', 'image', 'video', 'pdf']:
                if indexes[0] == 'main':
                    window_number = 0
                else:
                    window_number = indexes[2]
                
                yield indexes, data['id'], data['state']['state']['file']
        else:    
            for k, v in data.items():
                yield from leaf_indexes(v, indexes + [k], depth + 1)
    elif isinstance(data, list):
        for i, item in enumerate(data):
            yield from leaf_indexes(item, indexes + [i], depth + 1)


workspace_path = os.path.join(vault_path, '.obsidian/workspace.json')
with open(workspace_path) as f:
    data = json.load(f)

for index, mid, mfile in leaf_indexes(data):
    assert all([x == 'children' for x in index[1::2]])
    index_orig = index
    index = index.copy()
    
    tab = index.pop(-1)
    
    if index[0] == 'main':
        window = 0
        index = index[1:]
    else:
        window = 1 + index[2]
        index = index[3:]

    panes = index[1::2]
    
    n = 60
    mfile_str = mfile if len(mfile) < n else mfile[:n-3] + '...'
    window_str = '#' + str(window + 1)
    tab_str = '#' + str(tab + 1)
    name = f'{mfile_str:{n}}'
    name += '    '
    name += f'Window {window_str:3}  Tab {tab_str:3}'

    if len(panes) > 1:
        x = ', '.join(map(str, panes))
        name += f'  (pane {x})'

    # print(name)
    out = name + '\0info\x1f' + str(mid)
    print(out)
