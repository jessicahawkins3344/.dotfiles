#!/bin/bash

## github ssh

echo 'Checking for SSH key, generating one if it does not exist...'
  [[ -f '~/.ssh/id_rsa.pub' ]] || ssh-keygen -t rsa

echo 'Copying public key to clipboard. Paste it into your Github account...'
  [[ -f '~/.ssh/id_rsa.pub' ]] && cat '~/.ssh/id_rsa.pub' | pbcopy
  open 'https://github.com/account/ssh'

# Terminal Settings

# Use a modified version of the Pro theme by default in Terminal.app
open "~/.dotfiles/osxterminal/christophera-light.terminal"
sleep 1 # Wait a bit to make sure the theme is loaded
open "~/.dotfiles/osxterminal/christophera-dark.terminal"
sleep 1 # Wait a bit to make sure the theme is loaded
defaults write com.apple.terminal 'Default Window Settings' -string 'christophera-dark'
defaults write com.apple.terminal 'Startup Window Settings' -string 'christophera-dark'
