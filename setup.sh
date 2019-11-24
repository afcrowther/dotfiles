#!/bin/bash

remove_if_exists() {
  echo "Checking for file $1"
  if [ -f $1 ]; then
    echo "Removing existing $1 file"
    rm $1
  fi
}

link_file_to_home() {
  echo "Linking file $1 to ~/.$1"
  ln -s "$(pwd)/$1" ~/.$1
}

remove_existing_and_link_file() {
  remove_if_exists ~/.$1
  link_file_to_home $1
}

echo "Setting up environment..."
cd "$(dirname $0)"
# required files
dotfiles=("profile" "aliases" "functions.sh" "fzf.zsh" "gitignore_global" "gitconfig" "p10k.zsh" "tmux.conf" "tmux.conf.local" "zshrc")

# handle neovim config
remove_if_exists ~/.config/nvim/init.vim
mkdir -p ~/.config/nvim
ln -s "$(pwd)/init.vim" ~/.config/nvim/init.vim

alias vim="nvim"

for dotfile in "${dotfiles[@]}"
do
  remove_existing_and_link_file $dotfile
done
