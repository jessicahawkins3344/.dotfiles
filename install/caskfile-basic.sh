#!/bin/bash

# ~/.dotfiles/caskfile-basic.sh -- install basic set of Mac applications
# symlinked into ~/Applications
#
# also sourced by `allosxupdates.sh`

# Development Tools
brew cask install atom
brew cask install github #https://mac.github.com
brew cask install java # http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

# cleanup
brew linkapps --local
brew cleanup
brew prune
brew cask cleanup
