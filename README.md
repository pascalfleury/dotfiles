# Dotfiles

Clone them this way:

```
git clone https://github.com/Billiam/homeshick.git $HOME/.homesick/repos/homeshick
alias homeshick=$HOME/.homesick/repos/homeshick/home/.homeshick
homeshick clone https://github.com/pascalfleury/dotfiles.git
homeshick link dotfiles
```

This will set it up for all the next time. Immediate needs are covered by running

```
source $HOME/.bashrc
```
