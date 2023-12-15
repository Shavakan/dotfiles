#!/bin/bash

###############################################################################
# Shavakan 17.07.03 :: Word of Acknowledgement
# This dotfiles structure and install scripts are greatly motivated by the works of webpro
# (https://github.com/webpro/dotfiles).
#
# TODO: Add README/help option
# TODO: Make all the default options non-default. Make help default option instead.
###############################################################################

# Get current dir (so this script can run from everywhere)

export DOTFILES_DIR DOTFILES_CACHE EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_CACHE="$DOTFILES_DIR/.cache.sh"
EXTRA_DIR="$HOME/.extra"

# Import common functions

. "$DOTFILES_DIR/system/function"

# Update dotfiles themselves first

echo "Updating dotfiles themselves..."
if is-executable git -a -d "$DOTFILES_DIR/.git"; then git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master; fi

# Create workspace directory

mkdir -p $HOME/workspace

# Create SSH keygen (RSA pubkey) if one does not exist.

if [ -f ~/.ssh/id_rsa.pub ] 
then
	echo "RSA pubkey already exists. Skip keygen."
else
	echo "Creating RSA pubkey..."
	ssh-keygen -t rsa -b 4096 -C "chiyah92@gmail.com"
	echo "$cat ~/.ssh/id_rsa.pub" 
	cat ~/.ssh/id_rsa.pub 
	echo "RSA pubkey generated."
fi
ssh-add

# Install XCode Update
if xcode-select --print-path &>/dev/null; then
    echo "Xcode Command Line Tools are already installed."
else
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
fi

# Install Homebrew
if command -v brew >/dev/null 2>&1; then
    echo "Homebrew is already installed."
else
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Neovim
if command -v nvim >/dev/null 2>&1; then
    echo "NeoVim is already installed."
else
    echo "NeoVim is not installed. Installing NeoVim from pre-built binaries..."
    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
    tar xzf nvim-macos.tar.gz
    # Optionally, move nvim to a location in your PATH
    mv nvim-macos/bin/nvim /usr/local/bin/
    rm nvim-macos.tar.gz

    # Install and link gettext for libintl.8.dylib
    echo "Installing and linking gettext for NeoVim dependencies..."
    brew install gettext
    brew link gettext --force
fi

# Install AWS CLI
if command -v aws >/dev/null 2>&1; then
    echo "AWS CLI is already installed."
else
    echo "AWS CLI is not installed. Installing AWS CLI..."
    echo "Note: This installation will require administrative privileges."
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
    sudo installer -pkg AWSCLIV2.pkg -target /
    rm AWSCLIV2.pkg
fi

# Install Asdf VM
if [ -d "$HOME/.asdf" ]; then
    echo "asdf-vm is already installed."
else
    echo "Installing asdf-vm..."
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1
fi

# GPG
if command -v gpg >/dev/null 2>&1; then
    echo "GPG is already installed."
else
    echo "GPG is not installed. Installing GPG..."
    brew install gnupg
fi

case "$1" in
	all)
		# Disable Character Accent Menu
		defaults write -g ApplePressAndHoldEnabled -bool false
esac

# Install oh-my-zsh (zsh only)
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is already installed."
else
    if [[ "$SHELL" == *"zsh"* ]]; then
        echo "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        echo "Skipping Oh My Zsh installation as the current shell is not Zsh."
    fi
fi

# Install Saml2aws
if command -v saml2aws >/dev/null 2>&1; then
    echo "saml2aws is already installed."
else
    echo "saml2aws is not installed. Installing saml2aws..."
    brew install saml2aws
fi

# Create symlinks

# VSCODE_SETTINGS_DIR=$HOME/Library/Application\ Support/Code/User/ mkdir -p $VSCODE_SETTINGS_DIR && ln -svf $VSCODE_SETTINGS_DIR/vscode_settings.json 
echo "Creating symlinks for dotfiles..."
ln -sfv "$DOTFILES_DIR/system/bash_profile" ~/.bash_profile
ln -sfv "$DOTFILES_DIR/alias/bash_aliases" ~/.bash_aliases
ln -svf "$DOTFILES_DIR/system/zshrc" ~/.zshrc
ln -sfv "$DOTFILES_DIR/system/inputrc" ~/.inputrc
ln -sfv "$DOTFILES_DIR/git/gitconfig" ~/.gitconfig
ln -sfv "$DOTFILES_DIR/system/vimrc" ~/.vimrc
ln -sfv "$DOTFILES_DIR/Brewfile" ~
ln -sfv "$DOTFILES_DIR/git/gitignore_global" ~/.gitignore_global
ln -sfv "$DOTFILES_DIR/system/eclrc" ~/.eclrc
ln -sfv "/Volume/Keybase/private/changwonlee/shavakan_180131.pem" ~/.ssh/shavakan_180131
ln -sfv "/Volume/Keybase/private/changwonlee/devsisters.sh" ~/.devsisters.sh

# Reload new rc
case "$SHELL" in
    */bash)
        echo "Reloading .bashrc..."
        source ~/.bashrc
        ;;
    */zsh)
        echo "Reloading .zshrc..."
        source ~/.zshrc
        ;;
    *)
        echo "Unsupported shell. Please manually reload your shell configuration."
        ;;
esac
