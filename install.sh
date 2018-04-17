#!/bin/bash

NORMAL="\e[0m"
ERROR="\e[0;31m"
INFO="\e[0;33m"
HEADER="\e[0;34m"
OK="\e[0;32m"

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create symlink: $1 = source file, $2 = link path, $3 = link name
create_symlink() {
    echo -e " $OK -> $NORMAL Creating symlink for $3"
    ln -sf $1 $2/$3
}

# Backup file: $1 = path, $2 = filename
backup_file() {
    backup_name="$2_$(date +%d-%m-%y_%H%M%S).bak"
    echo -e " $INFO -> $NORMAL Backing up $2 as '$backup_name'"
    mv $1/$2 $1/$backup_name
}

setup_local_folders() {
    echo -e "$HEADER Setting up local 'bin' and 'scripts' folders $NORMAL"
    if [ ! -d $HOME/bin ]; then
        mkdir $HOME/bin
    fi
    create_symlink `which nvim` $HOME/bin vim

    if [ ! -d $HOME/scripts ]; then
        mkdir $HOME/scripts
    fi
    echo -e " $OK -> $NORMAL Downloaded 'git-prompt.sh' to scripts folder"
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh \
        --output-document=$HOME/scripts/git-prompt.sh -q
}

process_bash_configs() {
    echo -e "$HEADER Processing 'bash configs' $NORMAL"
    config_files=(aliases bash_profile bash_prompt bashrc exports functions inputrc path)
    for file in ${config_files[@]}; do
        if [ ! -h $HOME/.${file} ] && [ -e $HOME/.${file} ]; then
            backup_file $HOME .${file}
        fi
        create_symlink $SOURCE_DIR/${file} $HOME .${file}
        # Source newly created files
        if [ ${file} == inputrc ]; then
            continue
        else
            . $HOME/.${file}
        fi
    done
    unset config_files
}

process_nvim_configs() {
    echo -e "$HEADER Processing 'neovim configs' $NORMAL"
    nvim_config_path="$HOME/.config/nvim"
    if [ ! -d $nvim_config_path ]; then
        mkdir -p $nvim_config_path
    fi

    # Array since I may break my vim file up into modules at some point
    config_files=(init.vim)
    for file in ${config_files[@]}; do
        if [ ! -h $nvim_config_path/${file} ] && [ -e $nvim_config_path/${file} ]; then
            backup_file $nvim_config_path ${file}
        fi
        create_symlink $SOURCE_DIR/config/nvim/${file} $nvim_config_path ${file}
    done
    unset config_files
}

# Install vim plug (neovim plugin manager)
install_vim_plug() {
  type curl > /dev/null 2>&1 || {
    echo -e "$ERROR Error: curl must be installed before installing vim plug $NORMAL"
    exit 1
  }
  #TODO: change to wget
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

setup_local_folders
process_bash_configs
process_nvim_configs
install_vim_plug

exit 0
