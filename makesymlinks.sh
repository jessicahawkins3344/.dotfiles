#!/bin/bash

# .dropfiles / makesymlink.sh
#
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles

echo "makesymlinks.sh begun."

#### Variables

dir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles/dotfiles_old             # old dotfiles backup directory
files="bashrc bash_profile curlrc gitattributes gitconfig gitignore profile prompt-colors.sh git-prompt-colors.sh inputrc git-prompt-colors.sh nanorc nano"    # list of files/folders to symlink in homedir

#### Create Directories

# create dotfiles_old in homedir
if [ ! -d $olddir ]; then mkdir -p $olddir; echo "...Created $olddir for backup."; fi

# change to the dotfiles directory
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
echo "...Creating symlinks in home directory."
for file in $files; do
    if [ -L ~/.$file ]; then unlink ~/.$file; echo "......Unlinking ~$file."; fi
    if [ -s ~/.$file ]; then cp ~/.$file $olddir; echo "......Copying old ~$file ~ to $olddir."; fi
    if [ -s ~/.$file ]; then rm ~/.$file; echo "......Removing old ~$file."; fi
    if [ -s $dir/$file ]; then ln -s $dir/$file ~/.$file; echo "......Adding symlink to for ~$file from $dir."; fi
done

echo "...All symlinks created."

echo "makesymlinks.sh complete."
