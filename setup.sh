#!/bin/zsh

# homebrew
if [[ $(uname -s) == 'Darwin' ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
fi;

# git
brew install git;

# clone dotfiles
git clone https://github.com/rapatao/dotfiles.git "${HOME}/.dotfiles";

# install packages
ls ${HOME}/.dotfiles/bin/setup/ | while read l; do echo "running ${l}"; source ${HOME}/.dotfiles/bin/setup/$l; done;