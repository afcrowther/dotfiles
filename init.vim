call plug#begin('~/.vim/plugged')

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-sensible'

call plug#end()

" colours
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark
colorscheme solarized8_flat

" tab options
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" line numbers
set number relativenumber
set nu ru
