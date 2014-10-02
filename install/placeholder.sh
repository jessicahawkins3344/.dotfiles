#!/bin/bash

DEV="$HOME/Development"
DOTFILES="$HOME/dotfiles"
BIN="/usr/local/bin"

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


## set hostname of machine

echo 'Enter new hostname of the machine (e.g. aegus)'
  read HOSTNAME
  sudo scutil --set HostName "$HOSTNAME"
  COMPNAME=$(sudo scutil --get HostName | tr '-' '.')
  sudo scutil --set ComputerName "$COMPNAME"
  sudo scutil --set LocalHostName "$COMPNAME"
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPNAME"

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

# Restart automatically if the computer freezes
systemsetup -setrestartfreeze on

# Enable fast user switching
defaults write /Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool YES
