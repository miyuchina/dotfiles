" ========== behavior =========================================================

set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

set ignorecase
set smartcase
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
Plug 'gentoo/gentoo-syntax'
Plug 'cespare/vim-toml'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-lexical'
Plug 'miyuchina/nvim-termrun'
Plug 'miyuchina/vim-sane'
call plug#end()

" fzf
nnoremap <leader><space> :Files<cr>

" toggle writing mode
let g:goyo_width = 80
let g:pencil#textwidth = 72
let g:lexical#thesaurus_key = '<leader>t'
let g:limelight_conceal_ctermfg = 'gray'

function ToggleWritingMode()
    setlocal spell!
    execute "Goyo"
    execute "TogglePencil"
    call lexical#init()
endfunction

nnoremap <leader>w :call ToggleWritingMode()<cr>

" ========== colorscheme ======================================================

colorscheme sane

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction

nnoremap <leader>s :call SynGroup()<cr>
