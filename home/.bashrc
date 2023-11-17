# /etc/skel/.bashrc:
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
  # Shell is non-interactive.  Be done now!
  return
fi

# Have some fail-safe settings here.
export PATH="/bin:/usr/bin:${PATH}"
export USER="${USER:-$(whoami)}"
export HOME="${HOME:-/home/${USER}}"

# Source global definitions
for file in /etc/bashrc /etc/bash.bashrc /etc/bash_completion; do
  [[ -f "${file}" ]] && source "${file}"
done

# Handle the terminal UTF-8 output mode
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# User specific aliases and functions go here (override system defaults)
export EDITOR='nano -w'

# Add /user/local
[[ -d /usr/local/bin ]] && PATH="/usr/local/bin:${PATH}"
[[ -d /usr/local/lib ]] && LD_LIBRARY_PATH="/usr/local/lib:${LD_LIBRARY_PATH}"

[[ -d "${HOME}/.local/bin" ]] && PATH="${HOME}/.local/bin:${PATH}"

# consider my personal aliases...
[[ -f "${HOME}/.alias" ]] && source "${HOME}/.alias"
[[ -d "${HOME}/bin" ]] && export PATH="${HOME}/bin:${PATH}"
[[ -f "${HOME}/.bash_local" ]] && source "${HOME}/.bash_local"

# Bind cursor keys to do intelligent history scanning
bind '"\e[A"':history-search-backward 2>/dev/null
bind '"\e[B"':history-search-forward  2>/dev/null

# Playfull stuff with history
export SHELLID="$(date +'%Y%m%d%H%M%S')$$"
export HIST_DIR="${HIST_DIR:-${HOME}/cli_history}"
export HIST_FILE="${HIST_FILE:-${HIST_DIR}/cli.$(hostname -s)}"
export HISTTIMEFORMAT=""
export PROMPT_COMMAND='echo $SHELLID $PIPESTATUS $USER@$HOSTNAME $(date +"%Y%m%d %H%M%S") $(printf %q "$PWD") "$(history 1)" >> $HIST_FILE'
# Simplification to put history into the hist file
export HISTCONTROL=ignoredups
#export PROMPT_COMMAND="history -a && `which exp` history \"\$(history 1)\""

# Access convenience for git5-* dirs.
[[ -z "${CDPATH}" ]] && CDPATH="."
if [[ -d "${HOME}/Projects" ]]; then
  CDPATH="${CDPATH}:${HOME}/Projects:$(ls -d ~/Projects/* | tr '\n' ':' | sed 's/:[^:]*$//g')"
fi
export CDPATH

# My prompt
if [[ -n "${PS1}" ]]; then
  # Careful: any $() command in this prompt will set the $? and therefore influence
  # what is displayed at the end with $(( $? ? 31 : 32 ))
  export PS1='\[\033[1;33m\]`tabit $?`\[\033[0;38m\]:\[\033[1;32m\]\W\[\033[0;38m\]\[\033[1;$(($??31:32))m\] \$\[\033[1;37m\] '
fi

# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
export LS_COLORS='no=00:fi=00:di=00;35:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:'

# for experiment dirs (cleanup before!)
export PATH="./bin:${PATH}"

# Add Android SDK tools
ANDROID_SDK="${HOME}/Apps/Android/android-sdk-linux"
if [[ -d "${ANDROID_SDK}" ]]; then
  export PATH="${PATH}:${ANDROID_SDK}/tools:${ANDROID_SDK}/platform-tools"
fi

# Add PlatformIO tools
if [[ -d "${HOME}/.platformio/penv/bin" ]]; then
  PATH="${HOME}/.platformio/penv/bin:${PATH}"
fi

# Add my own tools
for setup in $(ls "${HOME}/Projects/"*/exp-mytools/setup.sh 2>/dev/null); do
  toolsdir=$(dirname "${setup}")
  PATH="${toolsdir}/bin:${PATH}"
done

# Setup Emacs's VTerm communication
if [[ "${INSIDE_EMACS}" = 'vterm' ]] \
  && [[ -n "${EMACS_VTERM_PATH}" ]] \
  && [[ -f "${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh" ]]; then
  source "${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh"
  unset KONSOLE_DBUS_SERVICE
  unset KONSOLE_DBUS_SESSION
  unset KONSOLE_DBUS_WINDOW
fi

# Remove some cruft that creeps into the PATH.
if [[ -x $(which clean_path >/dev/null 2>&1) ]]; then
  export PATH="$(clean_path "$PATH")"
fi

[[ -f "${HOME}/.bashrc_local" ]] &&  source "${HOME}/.bashrc_local"
# Setup Emacs's VTerm communication
if [[ "${INSIDE_EMACS}" = 'vterm' ]] \
    && [[ -n "${EMACS_VTERM_PATH}" ]] \
    && [[ -f "${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh" ]]; then
        source "${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh"
fi
