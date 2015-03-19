#!/bin/bash

# ~/.dotfiles/brewfile-basic.sh -- install basic set brew files
#
# also sourced by `allosxupdates.sh`

# Important early installs
brew install hub # https://hub.github.com
brew install git-extras # https://github.com/visionmedia/git-extras
brew install bash-completion # http://bash-completion.alioth.debian.org
brew install bash-git-prompt # https://github.com/magicmonty/bash-git-prompt
brew install grc # http://korpus.juls.savba.sk/~garabik/software/grc.html
brew install python

# update Mac OSX's nano
brew tap homebrew/dupes #https://github.com/Homebrew/homebrew-dupes
brew install nano #http://www.nano-editor.org
## also updates curses
## .nanorc and nano colors forked from https://github.com/scopatz/nanorc

# Cleaning up Brew caches

brew linkapps --local
brew cleanup
brew prune
