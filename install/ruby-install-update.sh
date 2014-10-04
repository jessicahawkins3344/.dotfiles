#!/bin/bash

# Execute on a new machine via:

# Update Ruby

echo -e "\n  Updating Ruby,,."
echo "  Please be patient. This process may take a while to complete."

# disable documentation installation to speed up gem update

# Don't install documentation
echo "gem: --no-document" >> ~/.gemrc

sudo gem update --system
curl -L https://get.rvm.io | bash -s stable --rails --autolibs=enable
sudo gem update --system

echo -e "\n  Ruby updated."

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

echo -e "\n  Ruby is installed and updated."
