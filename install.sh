#!/bin/bash

NORMAL="\e[0m"
ERROR="\e[0;31m"
INFO="\e[0;33m"
HEADER="\e[0;34m"
OK="\e[0;32m"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create symlink: $1 = source file, $2 = link path, $3 = link name
function create_symlink {
    echo -e " $OK -> $NORMAL Creating symlink for $3"
    ln -sf $1 $2/$3
}

# Create path: $1 = full path
function create_directory {
    mkdir -p $1
}

# Backup file: $1 = path, $2 = filename
function backup_file {
    backup_name="$2_$(date +%d-%m-%y_%H%M%S).bak"
    echo -e " $INFO -> $NORMAL Backing up $2 as '$backup_name'"
    mv $1/$2 $1/$backup_name
}

function process_bash_configs {
    echo -e "$HEADER Processing 'bash configs' $NORMAL"
    config_files=(aliases bash_profile bash_prompt bashrc exports functions inputrc path)
    for file in ${config_files[@]}; do
        if [ -h $HOME/.${file} ] || [ ! -e $HOME/.${file} ]; then
    	    create_symlink $SOURCE_DIR/${file} $HOME .${file}
        else
    	    backup_file $HOME .${file}
        fi
        # Source newly created files
        if [ ${file} == inputrc ]; then
            continue
        else
            . $HOME/.${file}
        fi
    done
    unset config_files
}

function process_nvim_configs {
    echo -e "$HEADER Processing 'nvim configs' $NORMAL"
    nvim_config_path="$HOME/.config/nvim"
    if [ ! -e nvim_config_path ]; then
        create_directory $nvim_config_path
    fi

    # Array since I may break my vim file up into modules at some point
    config_files=(init.vim)
    for file in ${config_files[@]}; do
        if [ -h $nvim_config_path/${file} ] || [ ! -e $nvim_config_path/${file} ]; then
    	    create_symlink $SOURCE_DIR/config/nvim/${file} $nvim_config_path ${file}
        else
    	    backup_file $nvim_config_path ${file}
        fi
    done
    unset config_files

}

# Install dein (neovim plugin manager): $1 install path
function install_dein {
    type git > /dev/null 2>&1 || {
        echo -e "$ERROR Error: git must be installed before installing dein $NORMAL"
	    exit 1
    }
    repo_extension="dein/repos/github.com/Shougo/dein.vim"
    if [ ! -e $1/$repo_extension ]; then
        echo -e "$HEADER Installing 'dein - neovim plugin manager' $NORMAL"
	    create_directory $1
        git clone https://github.com/Shougo/dein.vim "$1/$repo_extension"
        echo -e "$INFO Open nvim and run 'call dein#install()' $NORMAL"
    fi
}

process_bash_configs
process_nvim_configs
install_dein "$HOME/.nvim"

exit 0
