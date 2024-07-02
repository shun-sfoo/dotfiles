#!/usr/bin/python

import subprocess
import os
import socket


sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)

server_address = f'/{os.environ["XDG_RUNTIME_DIR"]}/hypr/{os.environ["HYPRLAND_INSTANCE_SIGNATURE"]}/.socket2.sock'

sock.connect(server_address)

while True:
    new_event = sock.recv(4096).decode(("utf-8"))
    # print(new_event)

    for item in new_event.split("\n"):
        if "workspace>>" == item[0:11]:
            workspace_num = item[-1]
            print(workspace_num)
