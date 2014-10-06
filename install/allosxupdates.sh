#!/bin/bash

# Execute on a new machine via:

# $ curl -L https://raw.githubusercontent.com/ChristopherA/dotfiles/master/install/allosxupdates.sh | bash

# Ask for the administrator password upfront
echo -e "\nUpdating system software and developer tools. Your administrator password will be required."
sudo -v

# What kind of OS are we running?

echo -e "\nChecking System -- \c"

# If we on OSX, install OSX specific command line tools, brew, brew cask, etc.

if [[ `uname` == 'Darwin' ]]; then

  # Get OSX Version
  OSX_VERS=$(sw_vers -productVersion)
  OSX_VERS_FIRST=$(sw_vers -productVersion | awk -F "." '{print $2}')

  echo "we are installing on a Mac under OSX $OSX_VERS."

  # on 10.9+, we can leverage Software Update to get the latest CLI tools
  if [ "$OSX_VERS_FIRST" -ge 9 ];
  then

    # Define some variables...
    tmp_file=".softwareupdate.$$"
    reboot=""
    found_updates=""

    echo -e "\n  Checking Apple Software Update Server for available updates,\n  Please be patient. This process may take a while to complete... \c"
    sudo /usr/sbin/softwareupdate -l &> $tmp_file
    wait

    echo -e "\n"
    reboot=$(/usr/bin/grep "restart" $tmp_file | /usr/bin/wc -l | xargs )
    echo "    $reboot updates require a reboot."
    /usr/bin/grep "restart" $tmp_file

    echo ""
    found_updates=$(/usr/bin/grep -v "restart" $tmp_file | grep "recommended" | /usr/bin/wc -l | xargs )
    echo "    $found_updates updates do not require a reboot."
    /usr/bin/grep -v "restart" $tmp_file | grep "recommended"
    echo ""

    if [ $found_updates = "0" ]
      then
         echo "    No new recommended updates found."
      else
        if [ $reboot = "0" ]
        then
          echo "    Updates found, but no reboot required. Installing now."
          echo "    Please be patient. This process may take a while to complete."
          sudo /usr/sbin/softwareupdate -ia
          wait
          echo -e "\n  Finished with all Apple Software Update installations."
        else
          echo "    Updates found, reboot required. Installing now."
          echo "    Please be patient. This process may take a while to complete."
          echo -e "    Once complete, this machine will automatically restart.\n"
          sudo /usr/sbin/softwareupdate -ia
          wait
          echo -e "    Finished with all Apple Software Update installations."
        fi
      fi

    # cleaning up temp files before possible reboot
    /bin/rm -rf $tmp_file

    if [ $reboot != "0" ]
    then
      echo -e "\n  Apple Software Updates requiring restart have been installed."
      echo -e "  Please run this script again after restart.\n"
      read -p "Press any key to restart..." </dev/tty
      wait
      echo -e "\nRestarting..."
      sudo /sbin/shutdown -r now
    fi

    echo -e "\n  Checking to see if Apple Command Line Tools are installed."
    xcode-select -p &>/dev/null
    if [[ $? -ne 0 ]]
    then
      echo "    Apple Command Line Utilities not installed. Installing..."
      echo "    Please be patient. This process may take a while to complete."

      # Tell software update to also install OXS Command Line Tools without prompt
      ## As per https://sector7g.be/posts/installing-xcode-command-line-tools-through-terminal-without-any-user-interaction

      touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress

      sudo /usr/sbin/softwareupdate -ia
      wait

      /bin/rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
      echo -e "\n    Finished installing Apple Command Line Tools."
    else
      echo -e "\n    Apple Command Line Tools already installed."
    fi

    # Install Homebrew http://brew.sh or search for brew formulae at http://braumeister.org

    source ~/install/brew-updates.sh

    # Install Brew Cask: http://caskroom.io

    source ~/install/cask-install.sh

    # Essentials, installed even if brew and cask bundles files not available

    brew install git # http://git-scm.com

    # Basics bundles, install if exist

    if [ -e ~/.dotfiles/install/brewfile-basic.sh ]; then source ~/.dotfiles/install/brewfile-basic.sh; fi

    if [ -e ~/.dotfiles/install/caskfile-basic.sh ]; then source ~/.dotfiles/install/caskfile-basic.sh; fi

    # The whathis database, used by whatis and apropos, is only generated weekly, so run it after adding commands.

    sudo periodic weekly

 else
   echo "This script only supports OSX 10.9 Mavericks or better! Exiting..."
 fi

else
  echo "We are not running on a Mac! Install scripts for non-Macs are a work-in-progress."
fi

echo -e "\nFinished installation.\n"
