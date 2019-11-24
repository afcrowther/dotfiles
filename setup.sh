#!/bin/bash

# remove existing config files
if [ -f ~/.bashrc ]; then
	rm ~/.bashrc
fi

if [ -f ~/.aliases ]; then
	rm ~/.aliases
fi

if [ -f ~/.gitignore_global ]; then
	rm ~/.gitignore_global
fi

if [ -f ~/.gitconfig ]; then
	rm ~/.gitconfig
fi

# change dir to correct location
cd "$(dirname "$0")"
ln -s "$(pwd)/bashrc" ~/.bashrc
ln -s "$(pwd)/aliases" ~/.aliases
ln -s "$(pwd)/gitignore_global" ~/.gitignore_global
ln -s "$(pwd)/gitconfig" ~/.gitconfig

# load changes into shell
. ~/.bashrc

