call plug#begin('~/.vim/plugged')

Plug 'lifepillar/vim-solarized8'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'bling/vim-bufferline'
Plug 'ctrlpvim/ctrlp.vim'

" language specifics
Plug 'plasticboy/vim-markdown'

call plug#end()

" colours
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif
syntax enable
set background=dark
colorscheme solarized8_flat

set t_8b=^[[48;2;%lu;%lu;%lum
set t_8f=^[[38;2;%lu;%lu;%lum
set t_Co=256
set t_ut=

" tab options
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" line numbers
set number relativenumber
set nu ru

" nerd tree
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
let NERDTreeShowHidden=1

" git status symbols
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" airline
let g:airline_theme = 'solarized'
let g:airline_powerline_fonts = 1
