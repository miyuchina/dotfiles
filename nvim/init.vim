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
set noshowmode

set textwidth=80
set colorcolumn=+1

set undofile

set statusline=%<%f\ %h%m%r%=%-15.(%l,%c%V%)\ %p%%\ %y

let g:mapleader = "\<space>"

" ========== plugins ==========================================================

call plug#begin('~/.local/share/nvim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'gentoo/gentoo-syntax'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'miyuchina/nvim-termrun'
Plug 'ayu-theme/ayu-vim'
Plug 'itchyny/lightline.vim'
call plug#end()

" fzf
nnoremap <leader><space> :Files<cr>

" ========== colorscheme ======================================================

set termguicolors
let ayucolor="dark"
colorscheme ayu
let g:lightline = { 'colorscheme': 'ayu_dark' }

highlight Comment gui=italic
highlight String  gui=italic
highlight Keyword gui=italic
highlight Type    gui=italic

augroup Indent
    autocmd!
    autocmd FileType html,css,yaml set softtabstop=2 shiftwidth=2
augroup END

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction

nnoremap <leader>s :call SynGroup()<cr>
nnoremap <leader>x :!chmod +x %<cr>
