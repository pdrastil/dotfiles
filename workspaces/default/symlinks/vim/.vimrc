"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
" Petr Drastil — @pdrastil
"
" Sections:
"  -> General
"  -> Plugins
"   -> Plugin manager
"   -> Sensible VIM
"   -> Git
"   -> Powerline status bar
"   -> Start screen
"   -> Color schemes
"   -> File explorer
"   -> CtrlP file, buffer, tag search
"   -> Fuzzy file search
"   -> Code search via Ripgrep
"   -> Code highlighting
"   -> Code indentation
"   -> Code scope auto-close
"   -> Code linting
"   -> File icons
"  -> Colors and Fonts
"  -> User interface
"  -> Text indentation
"  -> File and text search
"  -> File extensions
"  -> Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <leader> to ',' from default '\' for extra key combinations
" Leader has to be specified early to activate additional mappings
let mapleader = ","

" Remap VIM 0 to first non-blank character
map 0 ^

" Do not create backup files, since most stuff is in SCM anyway
set nobackup noswapfile nowritebackup

" :W - Save file with sudo
" Useful for handling the permission-denied error
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Set last cursor position when opening files
augroup cursorpos
  autocmd!
  " Always jump to last know position.
  " Don't do it when the position is invalid or when inside of event
  " handler. Also don't do it when mark is first line which is default.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \ exe "normal! g'\"" |
    \ endif
augroup END

" Delete trailing white-space on save, useful for some filetypes
augroup trimspace
  autocmd!
  autocmd BufWritePre
    \ *.md,*.txt,*.js,*.py,*.wiki,*.sh,*.coffee
    \ :call CleanExtraSpaces()

  function! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
  endfunction
augroup END

" Ignored for wildcard expansion
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
" Avoid using standard Vim directory names like 'plugin'
if has('nvim')
  let vimplugdir='~/.config/nvim/plugged'
  let vimautoloaddir='~/.config/nvim/autoload'
else
  let vimplugdir='~/.vim/plugged'
  let vimautoloaddir='~/.vim/autoload'
endif

" Install plugin manager {{{
  if empty(glob(vimautoloaddir . '/plug.vim'))
    execute 'silent !curl -fLo ' . vimautoloaddir . '/plug.vim --create-dirs ' .
      \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
"}}}

" Install plugins
call plug#begin(vimplugdir)

  " Sensible VIM defaults
  if !has('nvim')
    Plug 'tpope/vim-sensible'
  endif

  " Git integration {{{
    " A Git wrapper so awesome, it should be illegal
    Plug 'tpope/vim-fugitive'

    " Git diff in the gutter and stage / undo hunks
    Plug 'airblade/vim-gitgutter'
    let g:gitgutter_map_keys = 0

    " Faster update for Git Gutter
    set updatetime=750
  "}}}

  " Powerline status bar {{{
    Plug 'vim-airline/vim-airline'

    " Use Powerline glyphs
    let g:airline_powerline_fonts = 1

    " Use tabline
    let g:airline#extensions#tabline#enabled = 1

    " Show just filename in tabline
    let g:airline#extensions#tabline#fnamemod = ':t'

    " Hide the mode text below status line e.g --INSERT--
    set noshowmode

    " Airline status bar symbols
    if !exists('g:airline_symbols')
      let g:airline_symbols = {}
    endif

    " Configure used symbols
    "let g:airline_left_sep = '»'
    "let g:airline_left_sep = '▶'
    "let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    "let g:airline_right_sep = '«'
    "let g:airline_right_sep = '◀'
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    "let g:airline_symbols.linenr = '␊'
    "let g:airline_symbols.linenr = '␤'
    "let g:airline_symbols.linenr = '¶'
    "let g:airline_symbols.linenr = ''
    "let g:airline_symbols.branch = '⎇'
    "let g:airline_symbols.branch = ''
    let g:airline_symbols.branch = "\uF126"
    let g:airline_symbols.paste = 'ρ'
    "let g:airline_symbols.paste = 'Þ'
    "let g:airline_symbols.paste = '∥'
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.whitespace = 'Ξ'
  " }}}

  " Fancy start screen {{{
      Plug 'mhinz/vim-startify'
      augroup startify
        autocmd!
        " No need to show spelling ‘errors’
        autocmd FileType startify setlocal nospell
      augroup END
  "}}}

  " Color schemes {{{
    Plug 'rakr/vim-one'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'tomasr/molokai'
    Plug 'cocopon/iceberg.vim'
  "}}}

  " File explorer {{{
    Plug 'preservim/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind', 'NERDTreeFromBookmark'] }

    let g:NERDTreeWinPos="right"
    let g:NERDTreeQuitOnOpen="1"
    let NERDTreeShowHidden=0

    noremap <C-n> :NERDTreeToggle<cr>
    noremap <C-g> :NERDTreeFind<cr>
  "}}}

  " CtrlP file, buffer, tag search {{{
    Plug 'ctrlpvim/ctrlp.vim'

    let g:ctrlp_cache_dir = '~/.vim/cache/ctrlp'
    let g:ctrlp_match_window = 'bottom,order:ttb'
    let g:ctrlp_max_height = 20
    let g:ctrlp_switch_buffer = 0
    let g:ctrlp_working_path_mode = 0

    " Search tags with Ctrl-i
    noremap <c-i> :CtrlPTag<cr>

    " User command for file search
    if executable('rg')
      " If riggrep is installed
      set grepprg=rg\ --color=never

      let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'

      " Ripgrep is fast enough that CtrlP doesn't need caching
      let g:ctrlp_use_caching = 0
    elseif executable('ag')
      " If the silver searcher is installed
      let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

      " Ag is fast enough that CtrlP doesn't need caching
      let g:ctrlp_use_caching = 0
    elseif executable('find')
      " Unix search
      let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
    elseif executable('dir')
      " Windows search
      let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'dir %s /-n /b /s /a-d']
    endif
  "}}}

  " Fuzzy file search {{{
    if executable('fzf')
      Plug '/usr/local/opt/fzf'
      Plug 'junegunn/fzf.vim'
      let g:fzf_layout = { 'down': '40%' }
    endif
  "}}}

  " Code highlighting {{{
    " Collection of language packs
    "Plug 'sheerun/vim-polyglot'

    " Highlight trailing whitespace
    Plug 'ntpeters/vim-better-whitespace'

    " Move to previous and next whitespace
    nnoremap ]w :NextTrailingWhitespace<CR>
    nnoremap [w :PrevTrailingWhitespace<CR>

    Plug 'luochen1990/rainbow'
    let g:rainbow#active = 1
  "}}}

  " Code indentation {{{
    Plug 'tpope/vim-sleuth'
    Plug 'editorconfig/editorconfig-vim'

    " Exclude Git fugitive plugin ???
    let g:EditorConfig_exclude_patterns = ['fugitive://.*']
  "}}}

  " Code scope auto-close {{{
    "Add smart 'end' for shell scopes
    Plug 'tpope/vim-endwise'

    " Auto-close parenthesis
    Plug 'Raimondi/delimitMate'
  "}}}

  " Code linting {{{
    Plug 'w0rp/ale'

    " Enable integration with airline.
    let g:airline#extensions#ale#enabled = 1
  "}}}

  " File Icons {{{
    " Must to be near the end because it changes the way some of the
    " other plugins like ctrl-p, startify, NERDTree, etc. work.
    Plug 'ryanoasis/vim-devicons'
  "}}}
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if empty($TMUX)
  if has('nvim')
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif

  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if has('termguicolors')
    set termguicolors
  endif
endif

" Set dark background
set background=dark

" Set color scheme and status bar theme
" Extra: dracula, molokai, iceberg, one
colorscheme iceberg

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't redraw UI while executing macros (good performance config)
set lazyredraw

" Show line numbers
set number

" Minimum number of lines above and below cursor
set scrolloff=5

" Add a bit extra margin to the left
set foldcolumn=1

" Show matching paired delimeter when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text indentation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" 1 tab == 2 spaces
set tabstop=2

" Insert 2 spaces when tab is pressed
set softtabstop=2

" An indent is 2 spaces
set shiftwidth=2

" Round indent to nearest shiftwidth multiple
set shiftround

" Linebreak on 500 characters
set lbr tw=500

" Keep current indent if no other indent rule
set autoindent

" Smart auto-indenting when starting a new line
set smartindent

" Wrap lines
set wrap

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File and text search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to search (/)
nmap <space> /

" Map Alt + <Space> to backwards search (?)
nmap <A-space> ?

" Jump to results as you type
"set incsearch

" Ignore case when searching
"set ignorecase

" When searching try to be smart about cases
"set smartcase

" Highlight search results
"set hlsearch

" Stop the highlighting for 'hlsearch' option
nmap <silent> <esc><esc> :nohlsearch<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File extensions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown settings
augroup markdown
  autocmd!
  autocmd BufRead,BufNewFile *.md call SetMarkdownOptions()

  function! SetMarkdownOptions()
    setlocal spell
    setlocal fo+=t
    setlocal fo-=l
    setlocal textwidth=80
  endfunction
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, buffers and tabs (layouts)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allow specified keys move to the next line
set whichwrap=<,>,h,l

" Smart movement between windows
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" Based on https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
" Hide buffer when it is abandoned
set hidden

" Open new empty buffer
nnoremap <leader>bt :enew<cr>
" Move to next buffer
nnoremap <leader>bl :bnext<cr>
" Move to previous buffer
nnoremap <leader>bh :bprevious<cr>
" Close current buffer and move to previous one
nnoremap <leader>bq :bprevious <bar> bdelete #<cr>

" Switch beetween buffers with number
nnoremap <leader>1 :1b<cr>
nnoremap <leader>2 :2b<cr>
nnoremap <leader>3 :3b<cr>
nnoremap <leader>4 :4b<cr>
nnoremap <leader>5 :5b<cr>
nnoremap <leader>6 :6b<cr>
nnoremap <leader>7 :7b<cr>
nnoremap <leader>8 :8b<cr>
nnoremap <leader>9 :9b<cr>

" Switch CWD to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Useful mappings for managing tabs
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tq :tabclose<cr>

" Toggle between current and the last accessed tab
let g:lasttab = 1
nmap <leader>tl : exe "tabn " . g:lasttab<cr>
augroup lasttab
  autocmd!
  autocmd TabLeave * let g:lasttab = tabpagenr()
augroup END

" Open a new tab with the current buffer path
" Useful when editing files in the same directory
nnoremap <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/
