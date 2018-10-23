#!/bin/bash

GIT_TEMPLATE_FILE="${HOME}/.dotfiles/etc/git/.gitconfig"

set -e

echo ''

info () {
  printf "  [ \033[00;34m..\033[0m ] $1"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

setup_gitconfig () {
  if ! [ -f $HOME/.gitconfig ]; then
    info 'setup gitconfig'

    user ' - What is your git author name?'
    read -e git_authorname
    user ' - What is your git author email?'
    read -e git_authoremail

    sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" ${GIT_TEMPLATE_FILE} > $HOME/.gitconfig

    success 'gitconfig'
  fi
}

setup_gitconfig