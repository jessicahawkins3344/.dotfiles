ChristopherA's dotfiles
-----------------------

My personal dotfiles and shell tools.

Currently optimized for Apple Mac OSX Mavericks & Yosemite, but the long range goal is that they will also work on a Linux VPS.

Always a work-in-progress, but usable.

Installation
------------

To install and use these dotfile scripts, you will need to have `git` installed on your computer. On the Macintosh, this means that you will need to have Apple's Command Line Tools installed.

To make it easier to bootstrap, this repository containts a script that you can run from the Terminal that will update a Mac (in particular, newly installed Mac system) with all the current system updates, the appropriate Command Lines Tools for your OS version, and install basic brew, brew cask and rvm package managers for easy addtional of your own tools. This script runs using curl, and will not leave itself on your system, making it useful even if you don't want to use the rest of my dotfiles.

Just paste the following command into the Terminal. If multiple Apple System Updates that need a reboot are required, you may have to run this command more than once:

```
curl -L https://raw.githubusercontent.com/ChristopherA/dotfiles/master/install/allosxupdates.sh | bash
```
Once you have a current system, these commands will clone this dotfile repository and set it up for your own use.

```
cd ~
git clone https://github.com/ChristopherA/dotfiles.git ~/.dotfiles
cd .dotfiles
./install/makesymlinks.sh
```
When you are ready, you can fork this repository to use it yourself on multiple machines. You will need to create your own ~/.bash_profile.local file with your git credentials ([example](https://gist.github.com/ChristopherA/503b172a5fcae5410492)), but otherwise it is ready to for you to customize yourself.

The shell script at `~/.dotfiles/install/installosx.sh` can also be run independently of the rest of these dotfiles, and is full of OSX "default write" preferences that are useful. However, the script can't be run from curl quit yet so you'll have to copy it to your home directory to use it.
