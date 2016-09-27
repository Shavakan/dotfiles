#!/bin/bash

case "$1" in
    brew)
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew tap homebrew/bundle
    ;;
    vim)
		git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    ;;
	ssh)
		ssh-keygen -t rsa -b 4096 -C "chiyah92@gmail.com"
		echo "$ cat ~/.ssh/id_rsa.pub"
		cat ~/.ssh/id_rsa.pub
	;;
esac
