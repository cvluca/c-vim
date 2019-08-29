#!/usr/bin/env bash

Color_off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green

BASEDIR=$(dirname $0)
cd $BASEDIR
CURRENT_DIR=`pwd`

msg() {
  printf '%b\n' "$1" >&2
}

success() {
  msg "${Green}[✔]${Color_off} ${1}${2}"
}

fail() {
  msg "${Red}[✘]${Color_off} ${1}${2}"
  exit 1
}

install_vim () {
  # backup old .vimrc file
  if [[ -f "$HOME/.vimrc" ]]; then
    mv "$HOME/.vimrc" "$HOME/.vimrc_old"
  fi

  # backup .vim and install
  if [[ -d "$HOME/.vim" ]]; then
		if [[ ! "$(readlink $HOME/.vim)" =~ \.c-vim$ ]]; then
			mv "$HOME/.vim" "$HOME/.vim_old"
      ln -s "$CURRENT_DIR" "$HOME/.vim"
    fi
  else
    ln -s "$CURRENT_DIR" "$HOME/.vim"
  fi

  success "Installed c-vim for vim"
}

main () {
  install_vim
  exit 0
}

main $@
