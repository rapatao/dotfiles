#!/bin/zsh

source "${HOME}/.zgen/zgen.zsh";

# if the init script doesn't exist
if ! zgen saved; then

  # load from file the plugins/themes
  
  ls ${HOME}/.dotfiles/etc/zsh | while read l; do source ${HOME}/.dotfiles/etc/zsh/$l; done;

  # generate the init script from plugins above
  zgen save
fi;

ls ${HOME}/.dotfiles/etc/alias | while read l; do source ${HOME}/.dotfiles/etc/alias/$l; done;

