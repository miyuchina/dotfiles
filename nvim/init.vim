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

" lightline
set noshowmode

" ctrlp
set wildignore+=.*,*/venv/*,*/__pycache__/*

" ========== plugins ==========================================================

call plug#begin('~/.local/share/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/lightline.vim'
Plug 'miyuchina/neovim-tumbleweed'
call plug#end()

" ========== key bindings =====================================================

nnoremap <cr>       :call QuickRun()<cr>
nnoremap <leader>gr :let g:run_cmd = ""<left>
nnoremap <leader>br :let b:run_cmd = ""<left>
nnoremap <leader>ar :let b:async_cmd = ""<left>
nnoremap <leader>ur :unlet g:run_cmd<cr>
nnoremap <C-c>      :call TermStop()<cr>
nnoremap <C-l>      :call TermClear()<cr>

" ========== colorscheme ======================================================

set background=dark
let g:lightline = { 'colorscheme': 'gruvbox' }
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
