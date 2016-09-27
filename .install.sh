#!/bin/bash

case "$1" in
    brew)
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew tap homebrew/bundle
    ;;
esac
