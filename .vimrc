" ── General ───────────────────────────────────────────────
set nocompatible
filetype plugin indent on
syntax on

set encoding=utf-8
set history=1000
set hidden
set autoread

" ── Persistent undo ───────────────────────────────────────
set undofile
set undodir=~/.vim/undodir
if !isdirectory($HOME.'/.vim/undodir')
  call mkdir($HOME.'/.vim/undodir', 'p', 0700)
endif

" ── UI ────────────────────────────────────────────────────
set number
set relativenumber
set cursorline
set colorcolumn=80
set scrolloff=8
set signcolumn=yes
set showcmd
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.o,*.out,*.obj,*.d,tags

" ── Search ────────────────────────────────────────────────
set incsearch
set hlsearch
set ignorecase
set smartcase

" ── Indentation ───────────────────────────────────────────
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

" ── Performance ───────────────────────────────────────────
set updatetime=100

" ── File navigation (no plugins needed) ───────────────────
set path+=**
set tags=./tags,tags;/

" ── Grep ──────────────────────────────────────────────────
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ -rn\ --\ $*
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" ── Leader ────────────────────────────────────────────────
let mapleader = " "

" ── Quickfix navigation ───────────────────────────────────
nnoremap ]q :cnext<CR>
nnoremap [q :cprev<CR>
nnoremap ]l :lnext<CR>
nnoremap [l :lprev<CR>

" ── Buffer navigation ─────────────────────────────────────
nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>
nnoremap <leader>b :ls<CR>:b<Space>

" ── Search quality of life ────────────────────────────────
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <CR> :nohlsearch<CR><CR>

" ── Command-line convenience ──────────────────────────────
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" ── C/C++ filetype settings ───────────────────────────────
augroup c_cpp_programming
  autocmd!
  autocmd BufRead,BufNewFile *.h setlocal filetype=c
  autocmd FileType c,cpp setlocal cindent
  autocmd FileType c,cpp setlocal cinoptions=:0,l1,t0,g0,(0
  autocmd FileType c,cpp setlocal colorcolumn=80
  autocmd FileType c   setlocal makeprg=gcc\ -Wall\ -Wextra\ -g\ %\ -o\ %:r
  autocmd FileType cpp setlocal makeprg=g++\ -Wall\ -Wextra\ -std=c++17\ -g\ %\ -o\ %:r
  autocmd FileType c,cpp nnoremap <buffer> <F5> :make<CR>:copen<CR>
augroup END

" ── Colorscheme ───────────────────────────────
set termguicolors
colorscheme catppuccin
set background=dark
