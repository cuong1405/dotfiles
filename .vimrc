" =============================================================================
" usr_05.1: THE CANONICAL START
" =============================================================================
if filereadable($VIMRUNTIME . '/defaults.vim')
  source $VIMRUNTIME/defaults.vim
endif

" =============================================================================
" usr_05.2: GLOBAL BEHAVIOR & UI (Overrides & Additions)
" =============================================================================
set hidden              " usr_07.4: Switch buffers without saving
set number              " usr_05.2: Show line numbers
set relativenumber      " tips.txt: Better for vertical motions (j/k)
set laststatus=2        " options.txt: Always show status line
set colorcolumn=80      " options.txt: Visual guide for the 80-char limit

" Search improvements (Overrides)
set ignorecase          " usr_05.2: Ignore case in search patterns
set smartcase           " usr_05.2: Override 'ignorecase' if pattern has caps
set hlsearch            " usr_05.2: Highlight search matches

" Undo & Backups
set backup              " usr_05.2: Keep a backup file
if has('persistent_undo')
  set undofile          " undo.txt: Undo persists after closing Vim
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
" usr_41.11: MAPPING BEST PRACTICES
" =============================================================================
let mapleader = " "

nnoremap <silent> <leader>h :nohlsearch<CR> " Clear highlight quietly

" =============================================================================
" usr_40.3 & usr_30: AUTOCOMMAND GROUPS
" =============================================================================
augroup MyVimrc
  autocmd!

  " usr_05.2: Set textwidth for text files
  autocmd FileType text setlocal textwidth=78

  " usr_44.11: Highlight trailing whitespace
  autocmd Syntax * syn match ErrorMsg /\s\+$/

  " ===========================================================================
  " usr_30: C-LIKE LANGUAGE OPTIMIZATIONS
  " ===========================================================================
  " Enable smart C-style indentation (Already in defaults, but forced here)
  autocmd FileType c,cpp,java,php setlocal cindent

  " usr_29.1: Recursive tags search (up to root).
  " To generate tags, run in project root: ctags -R .
  autocmd FileType c,cpp setlocal tags=./tags;,tags

  " usr_30.1: Auto-open Quickfix window if :make fails
  autocmd QuickFixCmdPost [^l]* nested cwindow
augroup END

" =============================================================================
" usr_05.5: OPTIONAL PLUGINS (Built-in)
" matchit is recommended in usr_05.5 but not enabled by defaults.vim.
" =============================================================================
if has('syntax') && has('eval')
  packadd! matchit
endif

" =============================================================================
" usr_41: SCRIPTING UTILITIES
" =============================================================================
command! Config edit $MYVIMRC
command! Reload source $MYVIMRC | echo "Config reloaded."
