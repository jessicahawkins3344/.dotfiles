#!/bin/bash

# ~/.dotfiles/caskfile-basic.sh -- install basic set of Mac applications
# symlinked into ~/Applications
#
# also sourced by `allosxupdates.sh`

# Essential Utilities
brew cask install dropbox
brew cask install mailplane
brew cask install sizeup

# Development Tools
brew cask install google-chrome
brew cask install dash # http://kapeli.com/dash

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
