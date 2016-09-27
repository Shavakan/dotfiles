"" Shavakan's .vimrc file (r01, 2016-09-27)
"" Written by ChangWon Lee <chiyah92@gmail.com>
"" Inspired by lifthrasiir (Kang Seonghoon <lifthrasiir@gmail.com>)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

scripte utf-8

"" Vundle configuration -------------------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Vim-script library
Plugin 'ascenator/L9'
" A tree explorer plugin for vim
Plugin 'scrooloose/nerdtree.git'
" Vim plugin to list, select and switch between buffers
Plugin 'Buffergator'
" A better JSON for Vim: distinct highlighting of keywords vs values,
" JSON-specific (non-JS) warnings, quote concealing
Plugin 'elzr/vim-json'
" HTML5 omnicomplete and syntax
Plugin 'othree/html5.vim'
" Add CSS3 syntax support to vim's built-in 'syntax/css.vim'
Plugin 'hail2u/vim-css3-syntax'
" Vim python-mode, PyLint, Rope, Pydoc, breakpoints from box
Plugin 'klen/python-mode'
" Syntax checking hacks for vim
Plugin 'scrooloose/syntastic'
" Vim Git runtime files
Plugin 'tpope/vim-git'
" A Git wrapper so awesome, it should be illegal
Plugin 'tpope/vim-fugitive'
" A git commit browser
Plugin 'junegunn/gv.vim'
" One colorscheme pack to rule them all!
Plugin 'flazz/vim-colorschemes'
Plugin 'chriskempson/vim-tommorow-theme'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"" ----------------------------------------------------------------

"" Syntax ---------------------------------------------------------
syn enable
syn sync fromstart

" Set colorscheme
colorscheme Tomorrow-Night
hi Normal ctermbg=none
hi NonText ctermbg=none
" -----------------------------------------------------------------

"" Editor ---------------------------------------------------------
set mouse=a                             " -- mouse cursor on
set noet bs=2 ts=4 sw=8 sts=0           " -- tabstop
set noai nosi hls is ic cf ws scs magic " -- search
set nu ru sc wrap ls=2 lz               " -- appearance
set expandtab                           " -- tab as spaces

" encoding and file format
set fenc=utf-8 ff=unix ffs=unix,dos,mac
set fencs=utf-8,cp949,cp932,euc-jp,shift-jis,big5,latin2,ucs2-le
"" ----------------------------------------------------------------

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" CHANGELOGS :
"" 2016-09-27  Initial revision
""
"" TODOS :
""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
