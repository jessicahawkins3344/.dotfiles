#!/bin/bash

# ~/.bashrc: executed by `bash` for non-login shells.

echo "~/.bashrc loaded."

# If not running interactively, don't do anything

# [ -z "$PS1" ] && return

# If there is prompt, source contents of Apple's default /etc/bashrc & .bash_profile

# [ -n "$PS1" ] && source /etc/bashrc

load_bashrc_files() {
    declare -a files=(
#        $HOME/.rvm/scripts/rvm # Load RVM into a shell session *as a function*
        $HOME/.dotfiles/shell/bash_options # Options
        $HOME/.dotfiles/shell/bash_exports # Exports
        $HOME/.dotfiles/shell/bash_aliases # Aliases
        $HOME/.dotfiles/shell/functions/* # Functions
        $HOME/.bash_profile.local # Local and private settings not under version control (e.g. git credentials)
    )

    # if these files are readable, source them
    for index in ${!files[*]}
    do
        if [[ -r ${files[$index]} ]]; then
            source ${files[$index]}
        fi
    done
}

load_bashrc_files
unset load_bashrc_files

# Because ~/.profile isn't invoked because the .bash_profile exists,
# we must source ~/.profile to get its settings:

if [ -f ~/.profile ]; then source ~/.profile; fi
