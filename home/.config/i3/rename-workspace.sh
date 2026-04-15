#!/bin/bash

[[ -z "$(which jq)" ]] && echo "No 'jq' command!"
[[ -z "$(which kdialog)" ]] && echo "No 'kdialog' command!"

num=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num'| cut -d"\"" -f2)

new_name=$(kdialog --inputbox "Workspace #${num} new name: ")
[[ -n "${new_name}" ]] && i3-msg rename workspace to "${num}:${new_name}"
