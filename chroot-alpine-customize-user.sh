#!/bin/sh
# shellcheck disable=SC1090
set -e
set -u
set -x

sudo chown -R app:app ~/

mkdir -p ~/.ssh/config.d/bnna.d
chmod 0700 ~/.ssh/config.d/bnna.d
chmod 0700 ~/.ssh/config.d
chmod 0700 ~/.ssh/

cp -RPp /tmp/app.sshconfig ~/.ssh/config 2> /dev/null
chmod 0600 ~/.ssh/config

cp -RPp /tmp/app.example.sshconfig ~/.ssh/config.d/bnna.d/example.sshconfig 2> /dev/null
chmod 0600 ~/.ssh/config.d/bnna.d/example.sshconfig

touch ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

if ! grep -q 'screen' ~/.profile 2> /dev/null; then
    echo "screen -xRS 'awesome' -s fish" >> ~/.profile
fi
if ! test -e ~/.bashrc; then
    ln -s .profile ~/.bashrc
fi

curl -sS https://webi.sh/ | sh
. ~/.config/envman/PATH.env
webi ssh-authorize \
    setcap-netbind \
    aliasman \
    bat \
    rg \
    serviceman \
    shellcheck \
    shfmt

webi ssh-pubkey 2> /dev/null > /dev/null
rm -rf ~/.ssh/id_*

webi \
    vim-leader \
    vim-shell \
    vim-sensible \
    vim-viminfo \
    vim-lastplace \
    vim-smartcase \
    vim-spell \
    vim-shfmt \
    vim-ale \
    vim-whitespace \
    vim-commentary

cp -RPp /tmp/app.alias.env ~/.config/envman/alias.env 2> /dev/null
mkdir -p ~/bin
chmod 0700 ~/.config ~/.profile ~/bin
chmod 0750 ~/.local ~/.local/*
chmod 0700 ~/.config/envman/
chmod 0755 ~/.config/envman/load.sh
chmod 0600 ~/.config/envman/PATH.env
chmod 0600 ~/.config/envman/alias.env

mkdir -p ~/bin/
# shellcheck disable=SC2016
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.config/envman/PATH.env

echo '// prefix=/home/app/.npm/node_modules' >> ~/.npmrc
chmod 0600 ~/.npmrc

cp -RPp /tmp/app.README.md ~/README.md 2> /dev/null
sudo chown -R app:app ~/

echo ''
echo 'done'
