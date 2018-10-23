#!/bin/bash

brew update
brew upgrade
brew cask upgrade

brew install coreutils moreutils findutils bash zsh
brew install gnu-sed --with-default-names
brew install wget --with-iri
brew install vim --override-system-vi

brew cleanup