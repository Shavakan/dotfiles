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

# Create symlinks

echo "Creating symlinks for dotfiles..."
ln -sfv "$DOTFILES_DIR/system/bash_profile" ~/.bash_profile
ln -sfv "$DOTFILES_DIR/alias/bash_aliases" ~/.bash_aliases
ln -sfv "$DOTFILES_DIR/system/inputrc" ~/.inputrc
ln -sfv "$DOTFILES_DIR/git/gitconfig" ~/.gitconfig
ln -sfv "$DOTFILES_DIR/system/vimrc" ~/.vimrc
ln -sfv "$DOTFILES_DIR/Brewfile" ~
ln -sfv "$DOTFILES_DIR/git/gitignore_global" ~/.gitignore_global

if [ ! -d "$HOME/workspace" ]; then
	mkdir $HOME/workspace
fi

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

case "$1" in
	brew)
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		brew update
		brew tap homebrew/bundle
		cd ~ && brew bundle && cd -
	;;
	vim)
		git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	;;
	ssh)
		ssh-keygen -t rsa -b 4096 -C "chiyah92@gmail.com"
		echo "$ cat ~/.ssh/id_rsa.pub"
		cat ~/.ssh/id_rsa.pub
		echo "RSA pubkey generated."
	;;
	git)
		if [ ! -d "$HOME/.git" ]; then
			cd ~ && mkdir .git && cd ~/.git/ && cd -
		fi
		if [ ! -d "$HOME/.git/git-completion.bash" ]; then
			cd $HOME/.git && wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash && cd -
		fi
	;;
	ruby)
		gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
		\curl -sSL https://get.rvm.io | bash -s stable --ruby
		source ~/.rvm/scripts/rvm
		rvm list
	;;
	mac)
		xcode-select --install
		sudo xcodebuild -license
	;;
	redis)
		sudo redis-server "/usr/local/etc/redis.conf"
		echo "$ redis-cli ping" && redis-cli ping
	;;
	all)
	# Install Homebrew
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

		xcode-select --install

		# Install Homebrew packages
		brew update
		brew bundle

		# Gem Update
		gem update --system
		gem install ecl

		pip install -U pip
		sudo pip install virtualenv virtualenvwrapper

		# AWS CLI
		sudo pip install awscli --upgrade --user

		# Disable Character Accent Menu
		defaults write -g ApplePressAndHoldEnabled -bool false
esac

# Reload new bashrc
if [ -f ~/.bash_profile ]; then
	source ~/.bash_profile
fi
echo "bashrc reloaded"

