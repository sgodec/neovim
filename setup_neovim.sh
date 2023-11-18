#!/bin/bash

# Update system and install necessary packages
sudo pacman -Syu
sudo pacman -S base-devel git wget python neovim tmux clang cppcheck gcc

# Install Python packages with pacman
sudo pacman -S python-pynvim python-flake8 python-black

# Install vim-plug for Neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Clone your Neovim configuration
git clone https://github.com/sgodec/neovim ~/.config/nvim

# Run Neovim and install plugins
nvim -c 'PlugInstall | qa'

