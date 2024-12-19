#! /bin/env bash

# For endeavouros

# Update system
yay
sudo pacman -Sy #just in case

# Install terminal and shell.
yay -S alacritty
yay -S nushell
yay -S oh-my-posh
yay -S zoxide

# Install appearance stuff.
yay -S picom
yay -S xborder-git
yay -S polybar

# Install editor
yay -S helix-git

# Install Rust
yay -S rustup
rustup update stable
rustup component add rust-analyzer

# Install music-related programs.
cargo install spotify_player --features streaming
yay -S cava
yay -S cli-visualizer

# Install sound processing
yay -S easyeffects
yay -S lsp-plugins

