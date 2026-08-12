#!/bin/bash

STARTUP_DIR="${HOME}/.config/autostart"

function xdg_open() {
  local file="$1"
  local command="$(awk -F= '/^Exec/ {print $2; exit}' "${file}")"
  ${command}
}

for prog in $(ls ${STARTUP_DIR}/*.desktop); do
  prog_name="$(basename "${prog}")"
  (xdg_open "${prog}" || notify-send --app-name="$(basename $0)" --icon=gtk-info "Launch issue" "Failed to launch ${prog_name%.desktop}") &
done
