#!/bin/bash

# remove original bashrc
if [ "~/.bashrc" ]; then
	rm ~/.bashrc
fi

# remove original aliases
if [ "~/.aliases" ]; then
	rm ~/.aliases
fi

# change dir to correct location
cd "$(dirname "$0")"
ln -s "$(pwd)/bashrc" ~/.bashrc
ln -s "$(pwd)/aliases" ~/.aliases

# load changes into shell
. ~/.bashrc
