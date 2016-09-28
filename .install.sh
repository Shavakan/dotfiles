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
    ruby)
        if brew ls --version gnupg && brew ls --version gnupg2; then
            echo "brew gnupg is installed"
        else
            brew install gnupg gnupg2
        fi
        gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
        \curl -sSL https://get.rvm.io | bash -s stable --ruby
        source ~/.rvm/scripts/rvm
        rvm list
    ;;
esac
