# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
fi

# Capture the current focused window. This only works
# when there is an X server we talk to.
if [[ -n "${DISPLAY}" && -x /usr/bin/arbtt-capture ]]; then
  declare -i arb_running
  arb_running=$(ps -e | grep arbtt-capture | wc -l)
  (( arb_running )) || /usr/bin/arbtt-capture &
fi

export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES="1600x1200,3840x2560,5120x1440"

[[ -f "${HOME}/.profile_local" ]] && source "${HOME}/.profile_local"
