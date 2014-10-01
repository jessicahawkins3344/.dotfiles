#!/bin/bash

# Execute on a new machine via:

# $ curl -L https://gist.github.com/ChristopherA/829c1984c5d718115ba4/raw/installosxupdates.sh | bash

# Ask for the administrator password upfront
echo -e "\nInstalling on a new machine. Administrator password is required."
sudo -v

# What kind of OS are we running?

echo -e "\nChecking System -- \c"

# If we on OSX, install OSX specific command line tools, brew, brew cask, etc.

if [[ `uname` == 'Darwin' ]]; then
  echo "we are installing on a Mac."

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

  source ~/.rvm/scripts/rvm

  echo -e "\n  Ruby is installed and updated."


  # Install Homebrew http://brew.sh or search for brew formulae at http://braumeister.org

  echo -e "\n  Checking to see if Homebrew is installed."

  if ! which brew &> /dev/null
  then
    echo "    Homebrew not installed. Installing..."
    echo "    Please be patient. This process may take a while to complete."

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    echo -e "\n    Finished installing Homebrew."

  else
      echo -e "\n    Homebrew already installed."
  fi

  echo "    Checking Homebrew configuration..."

  brew doctor
  brew update
  brew upgrade
  brew linkapps
  brew cleanup
  brew prune

  # Install Brew Cask: http://caskroom.io

  echo -e "\n  Checking to see if Brew Cask is installed."

  if ! brew cask &> /dev/null
  then
    echo "    Cask not installed. Installing..."
    echo "    Please be patient. This process may take a while to complete."

    brew install caskroom/cask/brew-cask

    echo -e "\n    Finished installing Cask."

  else
      echo -e "\n    Cask already installed, updating..."
      brew upgrade brew-cask &> /dev/null
  fi

  echo "    Checking Brew Cask configuration..."

  brew cleanup
  brew cask cleanup

  echo "    Cask installed and updated."

  # Install essential Brew and Casks here

  brew install git # http://git-scm.com
  brew install hub # https://hub.github.com
  brew install get-extras # https://github.com/visionmedia/git-extras
  brew install bash-completion # http://bash-completion.alioth.debian.org

  # Cleaning up Brew and Cask caches

  echo "Cleaning up Brew and brew Cask caches"
  brew linkapps
  brew cleanup
  brew prune
  brew cask cleanup

  # The whathis database, used by whatis and apropos, is only generated weekly, so run it after adding commands.

  sudo periodic weekly


else
  echo "We are not running on a Mac! Install scripts for non-Macs are a work-in-progress."
fi

echo -e "\nFinished installation.\n"
