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
set noshowmode

let g:mapleader = "\<space>"

" ========== plugins ==========================================================

call plug#begin('~/.local/share/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf.vim'
Plug 'miyuchina/neovim-tumbleweed'
call plug#end()

" fzf
nnoremap <leader><space> :Files<cr>

" ========== colorscheme ======================================================

colorscheme gruvbox
highlight Normal guibg=None

let g:lightline = { 'colorscheme': 'gruvbox' }
