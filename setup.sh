#!/bin/bash

# remove original bashrc
if [ -f ~/.bashrc ]; then
	rm ~/.bashrc
fi

# remove original aliases
if [ -f ~/.aliases ]; then
	rm ~/.aliases
fi

# remove original git config
if [ -f ~/.gitconfig ]; then
	rm ~/.gitconfig
fi

# change dir to correct location
cd "$(dirname "$0")"
ln -s "$(pwd)/bashrc" ~/.bashrc
ln -s "$(pwd)/aliases" ~/.aliases
ln -s "$(pwd)/gitconfig" ~/.gitconfig

# load changes into shell
. ~/.bashrc
