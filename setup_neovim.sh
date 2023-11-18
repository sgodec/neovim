#!/bin/bash

# Function to backup existing directory
backup_if_exists() {
    local dir_path="$1"
    if [ -d "$dir_path" ]; then
        local backup_dir="${dir_path}.backup_$(date +%Y%m%d_%H%M%S)"
        echo "Backing up existing directory '$dir_path' to '$backup_dir'"
        mv "$dir_path" "$backup_dir"
    fi
}

# Update system and install necessary packages
sudo pacman -Syu
sudo pacman -S base-devel git wget python neovim tmux clang cppcheck gcc

# Install Python packages with pacman
sudo pacman -S python-pynvim python-flake8 python-black

# Install vim-plug for Neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Backup and clone your Neovim configuration
backup_if_exists ~/.config/nvim
git clone https://github.com/sgodec/neovim ~/.config/nvim

# Install NVM (Node Version Manager) and back up existing NVM directory if it exists
backup_if_exists ~/.nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Load NVM into current session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Node.js using NVM
nvm install node

# Run Neovim and install plugins
nvim -c 'PlugInstall | qa'


