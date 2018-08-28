# Append to history file
shopt -s histappend

# Check window size after each command and adjust
# rows and columns as required
shopt -s checkwinsize

# Fix typo's when cding
shopt -s cdspell

# Enable programmable completion features
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Source all dot files
for file in ~/.{path,bash_prompt,exports,aliases,functions}; do
    # Source only if file is exists, is readable and is a normal file
    [ -r "$file" ] && [ -f "$file" ] && . "$file"
done
unset file

# vim: ft=sh ts=4 et sw=4:


export PATH="$HOME/.cargo/bin:$PATH"
