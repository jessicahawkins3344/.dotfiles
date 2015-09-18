#!/bin/bash

# ~/.bashrc: executed by `bash` for non-login shells.

# If there is no prompt (i.e. not running interactively), then don't do anything

if [ -z "$PS1" ]; then
   return
fi

# debug

echo "~/.bashrc loaded."

# If there is prompt, then source files .dotfiles/shell/

load_bashrc_files() {
    declare -a files=(
#       $HOME/.rvm/scripts/rvm # Load RVM into a shell session *as a function*
        $HOME/.dotfiles/shell/bash_options # Options
        $HOME/.dotfiles/shell/bash_exports # Exports
        $HOME/.dotfiles/shell/functions/* # Functions
        $HOME/.dotfiles/lib/* # Lib Functions
        $HOME/.dotfiles/plugins/* # Bash Plugins
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
# we must source ~/.profile to get its settings (paths, etc.):

if [ -f ~/.profile ]; then source ~/.profile; fi
