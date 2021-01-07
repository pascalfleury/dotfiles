# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 002

# if running bash
if [ -n "$BASH_VERSION" ]; then
    [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
fi

# Capture the current focused window. This only works
# when there is an X server we talk to.
if [[ -n "${DISPLAY}" && -x /usr/bin/arbtt-capture ]]; then
  /usr/bin/arbtt-capture &
fi

# Emacs Application Framework:
# Make sure D-Bus is getting started when logging in.
## Test for an existing bus daemon, just to be safe
if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
    ## if not found, launch a new one
    eval `dbus-launch --sh-syntax --exit-with-session`
    echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
else
    echo "D-Bus already running on $DBUS_SESSION_BUS_ADDRESS"
fi

[[ -f "${HOME}/.profile_local" ]] && source "${HOME}/.profile_local"
