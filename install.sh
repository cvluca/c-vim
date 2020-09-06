#!/usr/bin/env bash

Color_off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green

BASEDIR=$(dirname $0)
cd $BASEDIR
CURRENT_DIR=`pwd`

msg () {
  printf '%b\n' "$1" >&2
}

success () {
  msg "${Green}[✔]${Color_off} ${1}${2}"
}

fail () {
  msg "${Red}[✘]${Color_off} ${1}${2}"
  exit 1
}

install_vim () {
  # backup old .vimrc file and link
  if [[ -f "$HOME/.vimrc" ]]; then
    if [[ ! "$(readlink $HOME/.vimrc)" =~ $CURRENT_DIR/vimrc$ ]]; then
      mv "$HOME/.vimrc" "$HOME/.vimrc.old"
      success "backup .vimrc file to .vimrc.old"
      ln -s "$CURRENT_DIR/vimrc" "$HOME/.vimrc"
    fi
  else
    ln -s "$CURRENT_DIR/vimrc" "$HOME/.vimrc"
  fi

  # backup .vim folder and link
  if [[ -d "$HOME/.vim" ]]; then
    if [[ ! "$(readlink $HOME/.vim)" =~ $CURRENT_DIR$ ]]; then
      mv "$HOME/.vim" "$HOME/.vim.old"
      success "backup .vim folder to .vim.old"
      ln -s "$CURRENT_DIR" "$HOME/.vim"
    fi
  else
    ln -s "$CURRENT_DIR" "$HOME/.vim"
  fi
  success "Installed c-vim for vim"
}

install_vim_done () {
  if [[ ! -d "$CURRENT_DIR/plugged" ]]; then
    vim +PlugInstall! +PlugClean! +qall
  fi
  success "Installed plugins"
}

uninstall_vim() {
  # TODO
  success "Uninstalled c-vim for vim"
}

install_neovim () {
  if [[ -d "$HOME/.config/nvim" ]]; then
    if [[ ! "$(readlink $HOME/.config/nvim)" =~ $CURRENT_DIR$ ]]; then
      mv "$HOME/.config/nvim" "$HOME/.config/nvim.old"
      success "backup nvim folder nvim.old"
      ln -s "$CURRENT_DIR" "$HOME/.config/nvim"
    fi
  else
    mkdir -p "$HOME/.config"
    ln -s "$CURRENT_DIR" "$HOME/.config/nvim"
  fi
  success "Installed c-vim for neovim"
}

install_neovim_done () {
  if [[ ! -d "$CURRENT_DIR/plugged" ]]; then
    nvim +PlugInstall! +PlugClean! +qall
  fi
  success "Installed plugins"
}

uninstall_neovim () {
  # TODO
  success "Uninstalled c-vim for neovim"
}

use_default_setting () {
  if [[ ! -f "$CURRENT_DIR/coc-settings.json" ]]; then
    ln -s $CURRENT_DIR/coc-default-settings.json $CURRENT_DIR/coc-settings.json
  fi
}

usage () {
  echo "c-vim install script"
  echo ""
  echo "Usage ./install.sh -[option] [target]"
  echo ""
  echo "OPTIONS"
  echo ""
  echo " -i, --install      Install c-vim for vim or neovim (only vim by default)"
  echo " -u, --uninstall    Uninstall c-vim"
  echo " -h, --help         Show usage"
}

main () {
  if [ $# -gt 0 ]
  then
    case $1 in
      --uninstall|-u)
        echo "Trying to unistall c-vim"
        uninstall_vim
        uninstall_neovim
        exit 0
        ;;
      --install|-i)
        if [ $# -eq 2 ]
        then
          case $2 in
            neovim)
              install_neovim
              install_neovim_done
              use_default_setting
              exit 0
              ;;
            vim)
              install_vim
              install_vim_done
              use_default_setting
              exit 0
          esac
        fi
        install_vim
        install_neovim
        install_neovim_done
        use_default_setting
        exit 0
        ;;
      --help|-h)
        usage
        exit 0
        ;;
    esac
  else
    install_vim
    install_neovim
    install_neovim_done
    use_default_setting
  fi
}

main $@
