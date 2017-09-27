#!/bin/bash

# Setup symlinks back to this directory
# Backup any existing files, don't overwrite

source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dot_files=(aliases bash_profile bash_prompt bashrc exports functions inputrc path)
for file in ${dot_files[@]}; do
    if [ -h $HOME/.${file} ] || [ ! -e $HOME/.${file} ]; then
        echo -e "\e[0;32m->\e[0m Creating symlink for $file"
        ln -sfn $source_dir/${file} $HOME/.${file}
    else
	backup_name=".${file}_$(date +%d-%m-%y_%H%M%S).bak"
        echo -e "\e[0;31m->\e[0m Backing up $file as '$backup_name'"
	mv $HOME/.${file} $HOME/$backup_name
    fi
    if [ ${file} == inputrc ]; then
        continue
    else
        . $HOME/.${file}
    fi
done

unset dot_files

exit 0
