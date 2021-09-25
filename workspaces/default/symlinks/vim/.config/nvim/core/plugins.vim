" #############################################################
" # Plugin installation                                       #
" #############################################################
scriptencoding utf-8

" ---[ Plugin manager ]----------------------------------------
let vim_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(vim_plug_path)
  execute 'silent! curl -fLo ' . vim_plug_path . ' --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
unlet vim_plug_path

" ---[ Plugin install ]----------------------------------------
call plug#begin(stdpath('data') . '/plugged')
  " ---[ Git integration ]------------------------------------{{{
    " A Git wrapper so awesome, it should be illegal
    Plug 'tpope/vim-fugitive'
    " Show differences in versioned files
    Plug 'mhinz/vim-signify'
    " The VCS to use
    let g:signify_vcs_list = [ 'git', 'svn', 'hg' ]
    " Change the sign for certain operations
    let g:signify_sign_change = '~'
  "}}}

  " ---[ Indentation ]----------------------------------------{{{
    " Automatically detect indentation
    Plug 'tpope/vim-sleuth'
    " Support for .editorconfig files
    Plug 'editorconfig/editorconfig-vim'
    " Ensure plugin works with Tim Pope's fugitive
    let g:EditorConfig_exclude_patterns = ['fugitive://.*']
  "}}}

  " ---[ Completions ]----------------------------------------{{{
    " Add smart 'end' for shell scopes
    Plug 'tpope/vim-endwise'
    " Auto-close parenthesis
    Plug 'Raimondi/delimitMate'
    " Asynchronous language server & lint engine
    Plug 'dense-analysis/ale'
  "}}}

  " ---[ Highlighting ]---------------------------------------{{{
    " Clear search highlights automatically
    Plug 'romainl/vim-cool'
    " Highlight url links
    Plug 'itchyny/vim-highlighturl'
    " Highlight trailing whitespace
    Plug 'ntpeters/vim-better-whitespace'
    " Highlight matching parenthesis
    Plug 'luochen1990/rainbow'
    " Enable rainbow parenthesis
    let g:rainbow_active = 1
  "}}}

  " ---[ Color schemes ]--------------------------------------{{{
    Plug 'rakr/vim-one'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'tomasr/molokai'
    Plug 'sainnhe/sonokai'
    Plug 'cocopon/iceberg.vim'
  "}}}

  " ---[ VIM UI ]--------------------------------------------{{{
    " Status bar
    Plug 'vim-airline/vim-airline'
    " Enable tabline
    let g:airline#extensions#tabline#enabled = 1
    " Show only filename instead of full path
    let g:airline#extensions#tabline#fnamemod = ':t'
    " Use file formatter with relative path
    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
    " Show buffer number for easier switching between buffers
    " see https://github.com/vim-airline/vim-airline/issues/1149
    let g:airline#extensions#tabline#buffer_nr_show = 1
    " Do not draw separators for empty statusline sections
    " extracted from https://vi.stackexchange.com/a/9637/15292
    let g:airline_skip_empty_sections = 1
    " Use Powerline glyphs
    let g:airline_powerline_fonts = 1
    " Define custom symbols
    if !exists('g:airline_symbols')
      let g:airline_symbols = {}
    endif
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.spell = 'Ꞩ'

    " Fuzzy searcher
    Plug 'junegunn/fzf.vim'
    " Enable per-command history for fzf searches.
    " CTRL-N and CTRL-P will be automatically bound to next-history and
    " previous-history instead of down and up. If you don't like the change,
    " explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
    let g:fzf_history_dir = stdpath('data') . '/fzf-history'

    " Set fzf actions to given key bindings
    let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit'
    \ }

    " Set fzf layout to popup window
    let g:fzf_layout = {
      \ 'up':'~90%',
      \ 'window': {
        \ 'width': 0.8,
        \ 'height': 0.8,
        \ 'yoffset':0.5,
        \ 'xoffset': 0.5,
        \ 'highlight': 'Todo',
        \ 'border': 'sharp'
        \ }
      \ }

    " Customize fzf colors to match current color scheme
    " fzf#wrap() translates this to a set of `--color` options for fzf
    let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment']
    \ }

    " Format output from ripgrep
    command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview(), <bang>0)

    " Smooth scrolling
    Plug 'psliwka/vim-smoothie'
    " Start screen
    Plug 'mhinz/vim-startify'
    " Icons for various plugins
    " Must to be near the end because it changes the way some of the
    " other plugins like ctrl-p, startify, NERDTree, etc. work.
    Plug 'ryanoasis/vim-devicons'
  "}}}
call plug#end()

" Run PlugInstall if there are missing plugins
if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  augroup plug_init
    autocmd!
    autocmd VimEnter * PlugInstall --sync | quit | source $MYVIMRC
  augroup END
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ---[ Airline ]-----------------------------------------
