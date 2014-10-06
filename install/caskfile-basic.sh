#!/bin/bash

# ~/.dotfiles/caskfile-basic.sh -- install basic set of Mac applications
# symlinked into ~/Applications
#
# also sourced by `allosxupdates.sh`

# Note that `mackup` is installed by brewfile-basic, so dont' forget to update
# the ~/dotfiles/mackup.cfg file if you want settings backed up or restored.

# Essentials
brew cask install dropbox
brew cask install atom
brew cask install mailplane
brew cask install sizeup
brew cask install google-chrome

# Less essential
brew cask install transmission

# cleanup
brew linkapps
brew cleanup
brew prune
brew cask cleanup
