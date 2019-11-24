call plug#begin('~/.vim/plugged')


call plug#end()

set nocompatible	        " disable compatibility to old vi
set showmatch			        " show matching brackets
set ignorecase		        " case insensitive matching
set mouse=v		  	        " middle click paste with mouse
set hlsearch			        " highlight search results
set tabstop=2			        " width of tab
set expandtab			        " white spaces instead of tabs
set shiftwidth=2	        " auto-indent width
set autoindent		        " indent at the same amount of the previous line
set number	  	         	" enable line numbers
set wildmode=longest,list	" tab-completions
set cc=120  			        " line width
filetype plugin indent on	" allows auto-indenting depending on file type
syntax on
