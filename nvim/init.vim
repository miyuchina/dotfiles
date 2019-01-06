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
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'miyuchina/neovim-tumbleweed'
call plug#end()

" ========== runner settings ===================================================

nnoremap <cr>      :call tumbleweed#term_run(g:tw_cmd)<cr>
nnoremap <leader>r :let g:tw_cmd = ""<left>
nnoremap <leader>w :let g:tw_write_cmd = ""<left>
cnoremap <leader>f " . expand("%") . "

autocmd BufWritePost * call tumbleweed#term_run(g:tw_write_cmd)

" ========== colorscheme ======================================================

set background=dark
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
