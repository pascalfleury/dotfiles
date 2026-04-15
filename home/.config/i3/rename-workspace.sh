#!/bin/bash

new_name=$(i3-input -P "New workspace name: " | sed 's/^"//;s/"$//')
[[ -n "$newName" ]] && i3-msg rename workspace to "$new_name"
