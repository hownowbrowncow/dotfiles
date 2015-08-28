#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function addDotFiles() {
    rsync --exclude ".git/" --exclude "bootstrap.sh" -avh --no-perms . ~;
    source ~/.bashrc;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    addDotFiles;
else
    read -p "Sync dotfiles? (y/n)" -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        addDotFiles;
    fi;
fi;

unset addDotFiles;

git config --global user.email "me@nickc.io"
git config --global user.name "Nick C"
git config --global core.editor vim
