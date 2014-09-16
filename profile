#!/bin/bash

# ~/.profile: executed by the command interpreter for login shells.

echo "~/.profile loaded."

# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.  Note, however, that we will have a ~/.bash_profile and it
# will simply source this file as a matter of course.

# Here is where PATH and anything else global need to execute
# programs and how those programs find their libraries. This is shared
# by `cron`, so we really don't want interactive stuff here.

load_profile_files() {
    declare -a files=(
        $HOME/.dotfiles/shell/bash_paths # Path modifications
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
