" ========== behavior =========================================================

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
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf.vim'
Plug 'miyuchina/neovim-tumbleweed'
call plug#end()

" fzf
nnoremap <leader><space> :Files<cr>

" gitgutter
set updatetime=100

" ========== colorscheme ======================================================

colorscheme gruvbox
highlight Normal ctermbg=None

let g:lightline = { 'colorscheme': 'gruvbox' }

let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn
highlight GitGutterAdd    ctermfg=2 ctermbg=None
highlight GitGutterChange ctermfg=3 ctermbg=None
highlight GitGutterDelete ctermfg=1 ctermbg=None
