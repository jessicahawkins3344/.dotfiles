#!/bin/bash

# ~/.dotfiles/caskfile-basic.sh -- install basic set of Mac applications
# symlinked into ~/Applications
#
# also sourced by `allosxupdates.sh`

# Note that `mackup` is installed by brewfile-basic, so dont' forget to update
# the ~/dotfiles/mackup.cfg file if you want settings backed up or restored.

# Essential Utilities
brew cask install dropbox
brew cask install mailplane
brew cask install sizeup

# Dev Tools
brew cask install atom
brew cask install google-chrome
brew cask install dash # http://kapeli.com/dash
brew cask install github #https://mac.github.com

# Less essential
brew cask install transmission

# cleanup
brew linkapps --local
brew cleanup
brew prune
brew cask cleanup

# Apps not available in brew cask

# Logitech Preference Manager
## https://support.logitech.com/en_us/Product/illuminated-keyboard-for-mac-ipad-iphone

# Mac App Store apps that need to be downloaded

##
