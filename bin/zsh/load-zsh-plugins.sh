#!/bin/zsh

source "${HOME}/.zgen/zgen.zsh";

# if the init script doesn't exist
if ! zgen saved; then

  # load default plugins / themes
  ls ${HOME}/.dotfiles/etc/zsh | while read l; do source ${HOME}/.dotfiles/etc/zsh/$l; done;

  # load user plugins / themes
  mkdir -p ${HOME}/.dotfiles.d/zsh;
  ls ${HOME}/.dotfiles.d/zsh | while read l; do source ${HOME}/.dotfiles.d/zsh/$l; done;

  # generate the init script from plugins above
  zgen save
fi;

# set default aliases
ls ${HOME}/.dotfiles/etc/alias | while read l; do source ${HOME}/.dotfiles/etc/alias/$l; done;

# load user aliases 
mkdir -p ${HOME}/.dotfiles.d/alias;
ls ${HOME}/.dotfiles.d/alias | while read l; do source ${HOME}/.dotfiles.d/alias/$l; done;

# set user custom scripts folder
mkdir -p ${HOME}/.dotfiles.d/bin;

# export path with user scripts folder as well as default script folder
path=("${HOME}/.dotfiles.d/bin" "${HOME}/.dotfiles/bin/ext" $path)
export PATH

