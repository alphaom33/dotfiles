#!/bin/bash

zellij action new-tab
zellij action write-chars "uv run station_opengl.py"
zellij action send-keys "Enter"

zellij action new-tab
CUR_TAB=$(zellij action current-tab-info --json | jq '.tab_id')
ONE=$(zellij action list-panes --json | jq ".[] | select(.is_focused == true and .id != 0 and .tab_id == $CUR_TAB) | .id")
zellij action write-chars "uv run main.py -i 1 -s"
zellij action send-keys "Enter"
zellij action new-pane -d "Right"
zellij action write-chars "uv run main.py -i 2 -s"
zellij action send-keys "Enter"
zellij action new-pane -d "Down"
zellij action write-chars "uv run main.py -i 3 -s"
zellij action send-keys "Enter"
zellij action focus-pane-id $ONE
zellij action new-pane -d "Down"
zellij action write-chars "uv run main.py -i 4 -s"
zellij action send-keys "Enter"
