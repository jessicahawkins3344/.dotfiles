dotfiles
========

My personal dotfiles and shell tools.

Still a work-in-progress, but usable.

Installation
------------

This will install clone my dotfile repository and set it up for your own use. You will need to create your own ~/.bash_profile.local file with your git credentials ([example](https://gist.github.com/ChristopherA/503b172a5fcae5410492), but otherwise it is ready to for you to customize yourself. When you are ready, you can fork this repository to use it yourself on multiple machines.

```
cd ~
git clone https://github.com/ChristopherA/dotfiles.git ~/.dotfiles
cd .dotfiles
./makesymlinks.sh
```

You can also just run my updater script without installing any dotfiles. This will install any system updates, set up current command line development tools, and install basic brew, brew cask and rvm package managers for easy addtional of your own tools. This script runs using curl, and will not leave itself on your system.

```
curl -L https://raw.githubusercontent.com/ChristopherA/dotfiles/master/install/allosxupdates.sh | bash
```
