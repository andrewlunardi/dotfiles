#!/bin/bash

echo "Setting up dotfiles..."

#Install git kalau belum ada
which git || sudo pacman -S git --noconfirm

#Clone dotfiles
git clone --bare https://github.com/andrewlunardi/dotfiles.git $HOME/.dotfiles

#Alias Sementara
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

#Checkout config
dotfiles checkout 2>/dev/null || {
	echo "Backing up existing configs..."
	mkdir -p ~/.config-backup
	dotfiles checkout 2>&1 | grep "\s+\." | awk {'print $1'} | xargs -I{} mv {} ~/.config-backup/{}
	dotfiles checkout
}

dotfiles config --local status.showUntrackedFiles no

echo "Done! Dotfiles installed."
