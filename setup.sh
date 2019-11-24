#!/bin/bash

remove_if_exists() {
  if [ -f $1 ]; then
    echo "Removing existing $1 file"
    rm $1
  fi
}

link_file_to_home() {
  ln -s "$(pwd)/$1" ~/.$1
}

remove_existing_and_link_file() {
  remove_if_exists ~/.$1
  link_file_to_home $1
}

echo "Setting up environment..."
cd "$(dirname $0)"
# required files
dotfiles=("aliases" "functions.sh" "fzf.zsh" "gitignore_global" "gitconfig" "p10k.zsh" "vimrc" "zshrc")

for dotfile in "${dotfiles[@]}"
do
  remove_existing_and_link_file $dotfile
done
