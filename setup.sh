#!/bin/bash

# This script runs through the whole setup of the local environment. Has been
# tested to work with any 'yum' or 'apt' based system.

# Takes one argument, which is the optional proxy command to prefix on any 
# outbound network calls

# TODO: getopts, usage, proxy, backup dotfiles

_print_usage() {
  echo "$0 usage:" && grep ' .)\ #' $0; exit 0;
}

declare _PROXY_CMD
declare _INSTALL_CMD
declare _PACKAGES
_APT_PACKAGES=("zsh" "git" "fontconfig" "fonts-powerline" "nodejs" "neovim" "tmux" "fzf" "ruby" "ruby-full")
_YUM_PACKAGES=("zsh" "git" "fontconfig" "powerline-fonts" "nodejs" "neovim" "tmux" "fzf" "ruby" "ruby-full")
_DOTFILES=("profile" "aliases" "functions.sh" "fzf.zsh" "gitignore_global" "gitconfig" "tmux.conf" "zshrc")
_YUM_LOCATION='/usr/bin/yum'
_YUM_CMD="$_PROXY_CMD sudo ${_YUM_LOCATION} install -y"
_APT_LOCATION='/usr/bin/apt'
_APT_CMD="$_PROXY_CMD sudo ${_APT_LOCATION} install -y"
_PACKAGES=

# The following 2 functions have been copied and modified from pacapt, checks 
# /etc/issue then falls back to directly testing the installed package manager 
# https://github.com/icy/pacapt/blob/master/pacapt
_found_arch() {
  local __ostype=$1
  shift
  grep -qis "$*" /etc/issue && _OSTYPE="$__ostype"
}

_get_package_manager_for_distro() {
  _found_arch DKPG "Debian GNU/Linux"
  _found_arch DPKG "Ubuntu"
  _found_arch YUM  "CentOS"
  _found_arch YUM  "Red Hat"
  _found_arch YUM  "Fedora"

  case $_OSTYPE in
    YUM)
      echo 'Using yum package manager' && export _PACKAGES=${_YUM_PACKAGES[@]} && export _INSTALL_CMD=${_YUM_CMD} && return
      ;;
    DPKG)
       echo 'Using apt package manager' && export _PACKAGES=${_APT_PACKAGES[@]} export _INSTALL_CMD=${_APT_CMD} && return
      ;;
    *)
      echo 'Cannot detect OS type from /etc/issue, falling back to detecting package manager directly...'
      ;;
  esac

  if [[ -x "${_YUM_LOCATION}" ]]; then
    echo 'Using yum package manager' && export _PACKAGES=${_YUM_PACKAGES[@]} && export _INSTALL_CMD=${_YUM_CMD} && return
  elif [[ -x "${_APT_LOCATION}" ]]; then
    echo 'Using apt package manager' && export _PACKAGES=${_APT_PACKAGES[@]} export _INSTALL_CMD=${_APT_CMD} && return
  else
    echo 'Cannot find any package manager to use...'
  fi
}

_remove_if_exists() {
  echo "Checking for file $1"
  if [ -f $1 ]; then
    echo "Removing existing $1 file"
    rm $1
  fi
}

_link_file_to_home() {
  echo "Linking file $1 to ~/.$1"
  ln -s "$(pwd)/$1" ~/.$1
}

_remove_existing_and_link_file() {
  _remove_if_exists ~/.$1
  _link_file_to_home $1
}

_install_packages() {
  echo "Installing required packages..."

  for package in "${_PACKAGES[@]}"
  do
    echo "Installing $package with $_INSTALL_CMD"
    eval "$_INSTALL_CMD $package"
  done

  # install oh-my-zsh
  sh -c "$($_PROXY_CMD curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # remove defalt zsh conf
  rm ~/.zshrc

  # install vim plugin manager
  sh -c '"${_PROXY_CMD}" curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  # install tmux plugin manager
  $_PROXY_CMD git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  # install lunarvim
  $_PROXY_CMD bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

  echo "Packages installed..."
}

_install_config() {
  
  echo "Installing config..."

  cd "$(dirname $0)"

  for dotfile in "${_DOTFILES[@]}"
  do
    _remove_existing_and_link_file $dotfile
  done
}

_run() {
  echo 'Installing Dependencies...'
  _get_package_manager_for_distro

  if [[ -z $_INSTALL_CMD ]]; then
    echo 'Exiting setup, no supported package manager found'
    exit 1;
  fi

  _install_packages 
  _install_config

  echo 'Reloading environment...'
  reset
}

_run
