#!/bin/bash

[[ -z "$(which jq)" ]] && echo "No 'jq' command!"
[[ -z "$(which kdialog)" ]] && echo "No 'kdialog' command!"

# Get the number of the currently focused workspace
num=$(swaymsg -t get_workspaces | jq '.[] | select(.focused==true).num')

# Prompt for the new name
new_name=$(echo "" | wofi --dmenu --prompt "Workspace #${num} new name:")

# Rename the workspace (Quotes ensure spaces in the name are handled correctly)
[[ -n "${new_name}" ]] && swaymsg "rename workspace to \"${num}:${new_name}\""
