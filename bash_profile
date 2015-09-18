#!/bin/bash

# ~/.bash_profile: executed by the command interpreter for login shells.

echo "~/bash_profile loaded."

# Put all 'bash' inteface specific functionality here, such as theme,
# colors & prompt

load_bash_profile_files() {
    declare -a files=(
        $HOME/.dotfiles/shell/bash_colors # Custom colors
        $HOME/.dotfiles/shell/bash_prompt # Custom bash prompt
        $(brew --prefix)/etc/bash_completion # Bash completion (installed via Homebrew)
    )

    # if these files are readable, source them
    for index in ${!files[*]}
    do
        if [[ -r ${files[$index]} ]]; then
            source ${files[$index]}
        fi
    done
}

load_bash_profile_files
unset load_bash_profile_files

# Because of this file's existence, neither ~/.bash_login nor ~/.profile
# will be automatically sourced unless they are sourced by the shell code.
# Here we source ~/.bashrc which will then source ~/.profile.

if [ -f ~/.bashrc ]; then source ~/.bashrc; fi
source /Users/jessicahawkins/extras/composure.sh