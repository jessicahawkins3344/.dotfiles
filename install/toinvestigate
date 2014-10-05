#!/bin/bash

# To investigate
# http://secrets.blacktree.com/?search=finder
# auto accept facetime http://hints.macworld.com/article.php?story=20110222080854178
# facetime ringtone http://www.mackungfu.org/custom-facetime-ringtone
# http://blog.jameskyle.org/2010/08/osx-defaults-hacks/
# http://superuser.com/questions/677961/strategy-to-maintain-dotfiles-for-different-oss-i-e-osx-and-ubuntu

DEV="$HOME/Development"
DOTFILES="$HOME/dotfiles"
BIN="/usr/local/bin"

## install brew bundle

brew bundle $DOTFILES/osx/Brewfile

## sublime settings

if [[ `uname` == 'Darwin' ]]; then
  link "$dotfiles/sublime/Packages/User/Preferences.sublime-settings" "$HOME/Library/Application Support/Sublime Text 2/Packages/User/Preferences.sublime-settings"
fi

# Use black and white menu bar icons” setting for Dropbox
for p in /Applications/Dropbox.app/Contents/Resources/*-lep.tiff; do echo cp $p ${p%-lep.tiff}.tiff; done

# exclude directories from Time Machine backups
tmutil addexclusion ~/Downloads
tmutil addexclusion ~/Movies

## Install Menlo-ForPowerline Font
wget --directory-prefix=$HOME/Downloads/ https://gist.github.com/raw/1627888/c4e92f81f7956d4ceaee11b5a7b4c445f786dd90/Menlo-ForPowerline.ttc.zip
unzip ~/Downloads/Menlo-ForPowerline.ttc.zip -d ~/Downloads
cp ~/Downloads/Menlo-ForPowerline.ttc /Library/Fonts

# Symlink sublime user settings
SUBLIME_PACKAGES="$HOME/Library/Application Support/Sublime Text 3/Packages"
SUBLIME_USER_SETTINGS="$SUBLIME_PACKAGES/User"
mkdir -p "$SUBLIME_PACKAGES"
rm -rf "$SUBLIME_USER_SETTINGS"
ln -s $HOME/.sublime "$SUBLIME_USER_SETTINGS"

# Update sublime
sublimeup
# Pressing keys should repeat and not stop
defaults write com.sublimetext.3 ApplePressAndHoldEnabled -bool false

# MultimarkDown Quicklook
cd ~/Downloads
git clone https://github.com/oschrenk/MMD-QuickLook
cd MMD-QuickLook
make compile
make install
qlmanage -r

# github ssh

echo 'Checking for SSH key, generating one if it does not exist...'
  [[ -f '~/.ssh/id_rsa.pub' ]] || ssh-keygen -t rsa

echo 'Copying public key to clipboard. Paste it into your Github account...'
  [[ -f '~/.ssh/id_rsa.pub' ]] && cat '~/.ssh/id_rsa.pub' | pbcopy
  open 'https://github.com/account/ssh'
