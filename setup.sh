#!/bin/bash

# remove original bashrc
if [ "~/.bashrc" ]; then
	rm ~/.bashrc
fi

# change dir to correct location
cd "$(dirname "$0")"
ln -s "$(pwd)/bashrc" ~/.bashrc
