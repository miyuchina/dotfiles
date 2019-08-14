" ========== behavior =========================================================

set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

set nohlsearch
set incsearch
set inccommand=nosplit

set splitbelow
set splitright

set number
set showcmd

set undofile

set statusline=%<%f\ %h%m%r%=%-15.(%l,%c%V%)\ %p%%\ %y

let g:mapleader = "\<space>"

" ========== plugins ==========================================================

call plug#begin('~/.local/share/nvim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', {
            \ 'dir': '~/.local/share/fzf',
            \ 'do': './install --bin'
            \ }
Plug 'junegunn/fzf.vim'
Plug 'gentoo/gentoo-syntax'
Plug 'miyuchina/nvim-termrun'
Plug 'miyuchina/vim-sane'
call plug#end()

" fzf
nnoremap <leader><space> :Files<cr>

" ========== colorscheme ======================================================

colorscheme sane

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction

nnoremap <leader>s :call SynGroup()<cr>
