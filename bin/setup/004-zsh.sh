#!/bin/bash

git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen";

echo -e '
source ${HOME}/.dotfiles/bin/zsh/load-zsh-plugins.sh;
' >> "${HOME}/.zshrc";

source "${HOME}/.zshrc";


if ! grep "/usr/local/bin/bash" < /etc/shells &> /dev/null; then
    sudo sh -c 'echo /usr/local/bin/bash >> /etc/shells'
fi

if ! grep "/usr/local/bin/zsh" < /etc/shells &> /dev/null; then
    sudo sh -c 'echo /usr/local/bin/zsh >> /etc/shells'
fi

### Set default shell to your favorite shell ###
chsh -s "$(which zsh)" "$(whoami)"
echo "Log in again to start your proper shell"