" ========== behavior =========================================================

set termguicolors

set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

set nohlsearch
set incsearch

set splitbelow
set splitright

set number
set showcmd

set undofile

let g:mapleader = "\<space>"

" ========== plugins ==========================================================

call plug#begin('~/.local/share/nvim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/fzf.vim'
call plug#end()

" fzf
nnoremap <leader><space> :Files<cr>

" ========== colorscheme ======================================================

colorscheme nord
