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

" ========== plugins ==========================================================

call plug#begin('~/.local/share/nvim/plugged')
Plug 'dracula/vim'
Plug 'sheerun/vim-polyglot'
Plug 'miyuchina/neovim-tumbleweed'
call plug#end()

" ========== colorscheme ======================================================

set background=dark
colorscheme dracula
