" =============================================================================
" usr_05.1: THE CANONICAL START
" =============================================================================
if filereadable($VIMRUNTIME . '/defaults.vim')
  source $VIMRUNTIME/defaults.vim
endif

" =============================================================================
" usr_05.2, options.txt & tips.txt: GLOBAL BEHAVIOR
" =============================================================================
set hidden              " quickfix.txt: Switch buffers without saving.
set number              " usr_05.2: Show absolute line number.
set relativenumber      " options.txt: Essential for jump-distance navigation.
set laststatus=2        " options.txt: Always show status line.
set colorcolumn=80

" indent.txt: Documentation assumes 4 for its C-indenting examples
set shiftwidth=4
set softtabstop=4

" usr_25: Recommended for modern consistency (converts tabs to spaces)
set expandtab

" quickfix.txt 1.1: Prevent opening same file twice from lists.
set switchbuf=useopen,usetab

" Search improvements (Overrides)
set ignorecase          " usr_05.2: Ignore case in search patterns
set smartcase           " usr_05.2: Override 'ignorecase' if pattern has caps
set hlsearch            " usr_05.2: Highlight search matches

" Backup & Undo (usr_05.2)
if !has("vms")
  set backup
  if has('persistent_undo')
    set undofile
  endif
endif

" =============================================================================
" usr_06: COLORS & APPEARANCE
" =============================================================================
if has('termguicolors')
  set termguicolors
endif
set background=dark
try
  colorscheme catppuccin
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme desert
endtry

" =============================================================================
" usr_05.4 & tips.txt: MAPPINGS
" =============================================================================
let mapleader = " "

" Clear search highlight (usr_05.2 utility)
nnoremap <silent> <leader>h :nohlsearch<CR>

" tips.txt: Smooth scrolling for Insert mode.
inoremap <C-E> <C-X><C-E>
inoremap <C-Y> <C-X><C-Y>

" =============================================================================
" usr_05.2, 29, 30: AUTOCOMMAND GROUPS
" =============================================================================
augroup MyVimrc
  autocmd!

  " usr_05.2: Set textwidth for text files.
  autocmd FileType text setlocal textwidth=78

  " usr_30.2, 29.1, 29.4: C & C++ Native Suite.
  " 1. Enable built-in C-style indentation (usr_30.2)
  autocmd FileType c,cpp setlocal cindent

  " 2. Recursive tags search (usr_29.1)
  " To generate tags, run in project root: ctags -R .
  autocmd FileType c,cpp setlocal tags=./tags;,tags

  " 3. Include-Search Path (usr_29.4)
  " Essential for 'gf', '[i', and CTRL-X CTRL-I
  autocmd FileType c,cpp setlocal path=.,/usr/include/c++/**,/usr/include,,
augroup END

" =============================================================================
" usr_05.5: BUILT-IN PACKAGES
" =============================================================================
if has('syntax') && has('eval')
  packadd! matchit       " usr_05.5: Extend % matching.
  packadd! editorconfig  " usr_05.5: Style consistency.
  packadd comment        " usr_05.5: gc for commenting (highly recommended!)
  packadd hlyank         " usr_05.5: Visual feedback when yanking.
  packadd cfilter        " quickfix.txt: Filter lists via :Cfilter.
  packadd helpcurwin     " tips.txt: Help in current window.
endif

" =============================================================================
" usr_05.1: SCRIPTING UTILITIES
" =============================================================================
command! Config edit $MYVIMRC
command! Reload source $MYVIMRC | nohlsearch | echo "Config reloaded."
