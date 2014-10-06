#!/bin/bash

# ~/.dotfiles/install/cask-install.sh -- install Brew Cask: http://caskroom.io
#
# also sourced by `allosxupdates.sh`

# Can be executed remotely on a new machine via:

# $ curl -L https://raw.githubusercontent.com/ChristopherA/dotfiles/master/install/cask-install.sh | bash

# Script Debugger

SCRIPT_DEBUG=true
#SCRIPT_DEBUG=false

# kill on error
set -e

cask_install() {

if $SCRIPT_DEBUG; then echo "...Installing Cask."; fi

# Check for Homebrew installation

if $SCRIPT_DEBUG; then echo "...Checking if Homebrew installed."; fi

if ! which brew &> /dev/null
  then

    # Homebrew not installed, exit

    >&2 echo "Homebrew is not installed!"

    exit 1

  else

  if $SCRIPT_DEBUG; then echo "...Homebrew installed."; fi

fi

# Homebrew is installed, continue

# Check for Cask instalation

if $SCRIPT_DEBUG; then echo -e "...Checking if Brew Cask is installed."; fi

if ! brew cask &> /dev/null
  then
    if $SCRIPT_DEBUG
      then
        echo "...Cask not installed. Installing."
        brew install caskroom/cask/brew-cask
      else
        brew install caskroom/cask/brew-cask > /dev/null
    fi

    if $SCRIPT_DEBUG; then echo -e "...Finished installing Cask."; fi

  else
    if $SCRIPT_DEBUG; then echo -e "Cask already installed."; fi

fi

# Update the latest version of Homebrew

if $SCRIPT_DEBUG; then echo "...Updating Homebrew."; fi

if $SCRIPT_DEBUG
  then
    brew update
  else
    brew update > /dev/null
fi

# Upgrade outdated, unpinned brews

if $SCRIPT_DEBUG; then echo "...Upgrade outdated, unpinned brews."; fi

if $SCRIPT_DEBUG
  then
    brew upgrade
  else
    brew upgrade > /dev/null
fi

# Symlink any .app-style brews applications locally to ~/Applications

if $SCRIPT_DEBUG; then echo "...Symlink any .app-style brews."; fi

if $SCRIPT_DEBUG
  then
    brew linkapps --local
  else
    brew linkapps --local > /dev/null
fi


# Cleanup old brew formula

if $SCRIPT_DEBUG; then echo "...Cleanup old brew formula."; fi

if $SCRIPT_DEBUG
  then
    brew cleanup
  else
    brew cleanup > /dev/null
fi

# Cleanup old cask formula

if $SCRIPT_DEBUG; then echo "...Cleanup old cask formula."; fi

if $SCRIPT_DEBUG
  then
    brew cask cleanup
  else
    brew cask cleanup > /dev/null
fi

# Prune dead symlinks

if $SCRIPT_DEBUG; then echo "...Prune dead symlinks."; fi

if $SCRIPT_DEBUG
  then
    brew prune
  else
    brew prune > /dev/null
fi

if $SCRIPT_DEBUG; then echo "...Cask installed."; fi


} # end function load_bashrc_files()

cask_install
unset cask_install
