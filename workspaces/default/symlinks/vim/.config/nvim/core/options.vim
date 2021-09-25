" #############################################################
" # Builtin options and setting                               #
" #############################################################
scriptencoding utf-8

" ---[ File and encoding  ]------------------------------------
" File encoding for new file
set fileencoding=utf-8
" Hide buffer when it is abandoned
set hidden
" Ask for confirmation when handling unsaved or read-only files
set confirm
" Do not create swapfiles
set noswapfile
"Persistent undo even when you close a file
set undofile
" Ignroe certain files and folders when globbing
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*/__pycache__/*,*/build/**
set wildignore+=*.o,*~,*.pyc,*.obj,*.bin,*.dll,*.exe
set wildignore+=*.jpg,*.png,*.jpeg,*.bmp,*.gif,*.tiff,*.svg,*.ico
set wildignore+=.DS_Store
" Case insensitive file and dir in cmd-completion
set wildignorecase

" ---[ VIM UI ]------------------------------------------------
" Set color scheme and status bar theme
" Extra: dracula, molokai, iceberg, one
colorscheme dracula

" Enable true colors support
if has('termguicolors')
  set termguicolors
endif

" Do not show mode on command line since vim-airline can show it
set noshowmode
" Don't redraw UI while executing macros (good performance config)
set lazyredraw
" Split window below/right when creating horizontal/vertical windows
set splitbelow splitright
" Enable mouse support for selection, windows, etc.
set mouse=nic

" Time in miliseconds to wait for a mapped sequence to complete,
" see https://unix.stackexchange.com/q/36882/221410 for more info
set timeoutlen=1000
" Update time for EventHandlers
set updatetime=100

" Clipboard settings, always use clipboard for all delete, yank, change, put
" operation, see https://stackoverflow.com/q/30691466/6064933
if !empty(provider#clipboard#Executable())
  set clipboard+=unnamedplus
endif

" ---[ Editor ]------------------------------------------------
set number                        " Show line numbers
set showmatch                     " Show matching paired delimeter when text indicator is over them
set scrolloff=3                   " Minimum number of lines above and below cursor
set textwidth=500                 " Maximum width of text line
set linebreak                     " Linebreak for text lines that exceed maximum width
set showbreak=↪                   " Character to show before the lines that have been soft-wrapped
set foldcolumn=1                  " Add a bit extra margin when wrapping text
set whichwrap=b,s,h,l,<,>,[,]     " Allow cursor keys movement to the next line

" ---[ Indentation  and tabs ]---------------------------------
set expandtab                     " Tabs are spaces, not tabs
set tabstop=2                     " Number of visual spaces per one tab
set softtabstop=2                 " Number of spaces in tab when editing
set autoindent                    " Keep current indent if no other indenting rule
set smartindent                   " Smart auto-indenting when starting a new line
set shiftwidth=2                  " Number of spaces for autoindent
set shiftround                    " Round indent to nearest shiftwidth multiple

" ---[ Searching  ]--------------------------------------------
set hlsearch                      " Highlight search results
set incsearch                     " Jump to search results as you type
set ignorecase                    " Ignore case when searching
set smartcase                     " When searching try to be smart about cases

" Use ripgrep for grep command
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m
endif
