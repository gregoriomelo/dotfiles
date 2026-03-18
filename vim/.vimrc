" Ensure Homebrew binaries are available to vim on macOS
let $PATH = '/opt/homebrew/bin:/opt/homebrew/sbin:' . $PATH

" Use POSIX shell for external commands — nushell breaks plugins like fzf
set shell=/bin/sh

" Use spaces instead of tabs
set expandtab

" 2 spaces default
set shiftwidth=2
set softtabstop=2
set tabstop=2

let mapleader = ","

" Add Homebrew fzf runtime files (recommended approach per fzf docs)
set rtp+=/opt/homebrew/opt/fzf

" ── Plugins ───────────────────────────────────────────────────────────────
call plug#begin('~/.vim/plugged')
  Plug 'preservim/nerdtree'       " File tree sidebar
  Plug 'vim-airline/vim-airline'  " Status line
  Plug 'junegunn/fzf.vim'         " Fuzzy file finder (requires fzf from Homebrew)
  Plug 'tpope/vim-surround'       " Surround text objects
call plug#end()

" ── NERDTree ──────────────────────────────────────────────────────────────
" Toggle with <leader>d  (matches maximum-awesome muscle memory)
nnoremap <leader>d :NERDTreeToggle<CR>
" Show hidden files
let NERDTreeShowHidden=1
" Quit vim when NERDTree is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
  \ && b:NERDTree.isTabTree()) | q | endif

" ── Search ────────────────────────────────────────────────────────────────
set hlsearch    " Highlight all matches
set incsearch   " Incremental search as you type
set ignorecase  " Case-insensitive...
set smartcase   " ...unless uppercase letters typed

" Clear highlight with <leader><space>
nnoremap <leader><space> :nohlsearch<CR>

" ── Status line ───────────────────────────────────────────────────────────
set laststatus=2              " Always show status line
let g:airline_powerline_fonts = 0  " No special fonts needed

" ── fzf ───────────────────────────────────────────────────────────────────
" Fuzzy file finder with ,t  (matches maximum-awesome muscle memory)
nnoremap <leader>t :Files<CR>
" Full-text search across project with ,f
nnoremap <leader>f :Rg<CR>
