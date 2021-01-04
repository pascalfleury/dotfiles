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

# Add /user/local
[[ -d /usr/local/bin ]] && PATH="/usr/local/bin:${PATH}"
[[ -d /usr/local/lib ]] && LD_LIBRARY_PATH="/usr/local/lib:${LD_LIBRARY_PATH}"

# consider my personal aliases...
[[ -f $HOME/.alias ]] && . $HOME/.alias
[[ -d $HOME/bin ]] && export PATH=$HOME/bin:$PATH
[[ -f $HOME/.bash_local ]] && source $HOME/.bash_local

# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
export LS_COLORS='no=00:fi=00:di=00;35:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:'

# Change the window title of X terminals
case "${TERM}" in
    xterm*|rxvt*|Eterm)
	PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
	;;
    screen)
	PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
	;;
esac

# Save shell history
shopt -s histappend
PROMPT_COMMAND="history -a;${PROMPT_COMMAND}"

# Add Android SDK tools
ANDROID_SDK="${HOME}/Apps/Android/android-sdk-linux"
if [[ -d "${ANDROID_SDK}" ]]; then
    export PATH="${PATH}:${ANDROID_SDK}/tools:${ANDROID_SDK}/platform-tools"
fi

# Add PlatformIO tools
if [[ -d "${HOME}/.platformio/penv/bin" ]]; then
    PATH="${HOME}/.platformio/penv/bin:${PATH}"
fi

# Setup Emacs's VTerm communication
if [[ "${INSIDE_EMACS}" = 'vterm' ]] \
       && [[ -n "${EMACS_VTERM_PATH}" ]] \
       && [[ -f "${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh" ]]; then
    source "${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh"
fi
