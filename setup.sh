#!/bin/bash

# based on https://github.com/wyattanderson/dotfiles/blob/master/setup.sh

git submodule update --init

# dotfile bootstrap
for file in vimrc vim zshrc zsh tmux.conf gitconfig git-prompt.sh; do
  # Check to see if the file already has a symlink. If it does, we won't touch
  # it.
  if [ ! -h ~/.${file} ]; then
    # If the file exists, ask the user if they'd like us to move it to
    # FILENAME_old. If we don't move it, ln won't overwrite it, it'll just
    # fail.
    if [ -e ~/.${file} ]; then
      read -p "Move existing $file to ${file}_old? y[n] " -n 1
      echo
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        mv ~/.${file} ~/.${file}_old
      fi
    fi
    # Add the appropriate symlink
    echo "Symlinking ~/code/dotfiles/${file} to ~/.${file}"
    ln -s ~/code/dotfiles/${file} ~/.${file}
  fi
done

# non-dot things; same as above otherwise
for file in scripts; do
  if [ ! -h ~/${file} ]; then
    if [ -e ~/${file} ]; then
      read -p "Move existing $file to ${file}_old? y[n] " -n 1
      echo
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        mv ~/${file} ~/${file}_old
      fi
    fi
    echo "Symlinking ~/code/dotfiles/${file} to ~/${file}"
    ln -s ~/code/dotfiles/${file} ~/${file}
  fi
done
