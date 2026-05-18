#!/bin/bash

echo "Setting up dotfiles..."

# Install dependencies dasar
sudo pacman -S --noconfirm git zsh curl wget

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh already installed, skipping..."
fi

# Install zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

# Clone dotfiles
if [ ! -d "$HOME/.dotfiles" ]; then
    echo "Cloning dotfiles..."
    git clone --bare https://github.com/andrewlunardi/dotfiles.git $HOME/.dotfiles
else
    echo "Dotfiles repo already exists, skipping..."
fi

# Pakai function, bukan alias
dotfiles() {
    /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}

# Checkout config
dotfiles checkout 2>/dev/null || {
    echo "Backing up existing configs..."
    mkdir -p ~/.config-backup
    dotfiles checkout 2>&1 | grep -E "\s+\." | awk '{print $1}' | xargs -I{} mv {} ~/.config-backup/{}
    dotfiles checkout
}

dotfiles config --local status.showUntrackedFiles no

# Set zsh sebagai default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting zsh as default shell..."
    chsh -s $(which zsh)
fi

echo "Done! Dotfiles installed."
echo "Please restart your terminal or run: exec zsh"
