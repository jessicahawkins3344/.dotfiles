#!/bin/bash

# ~/.profile: executed by the command interpreter for login shells.

# This file is not read by bash if ~/.bash_profile or ~/.bash_login
# exists. Note, however, that we will have a ~/.bash_profile and it
# must be sourced elsewhere, in typically by ~/.bashrc.

# The .profile is where PATH, aliases, and anything else global that
# for how those programs find their libraries or needs to be set to
# execute programs. This is shared  by `cron`, so we really don't want
# interactive stuff here.

# Show debug notice when there is path.
# (i.e. shell is interactive, and not during cron jobs).

if [ -n "$PS1" ]; then
   echo "~/.profile loaded."
fi

# pathhelper from Apple default /private/etc/bashrc, plus empty PATH
# as per http://www.softec.lu/site/DevelopersCorner/MasteringThePathHelper
if [ -x /usr/libexec/path_helper ]; then
	PATH=""
	eval `/usr/libexec/path_helper -s`
fi

load_profile_files() {
    declare -a files=(
        $HOME/.dotfiles/shell/bash_paths # Path modifications
        $HOME/.dotfiles/shell/bash_aliases # Aliases
        $HOME/.dotfiles/shell/extended/* # Extended Aliases
    )

    # if these files are readable, source them
    for index in ${!files[*]}
    do
        if [[ -r ${files[$index]} ]]; then
            source ${files[$index]}
        fi
    done
}

load_profile_files
unset load_profile_files
