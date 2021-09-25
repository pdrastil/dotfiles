" #############################################################
" # Custom commands                                           #
" #############################################################
scriptencoding utf-8

" :W - Save file with sudo
" Useful for handling the permission-denied error
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Set last cursor position when opening files
" Don't do it when the position is invalid or when inside of event
" handler. Also don't do it when mark is first line which is default.
augroup resume_cursor_pos
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \ exe "normal! g'\"" |
    \ endif
augroup END

" Delete trailing white-space on save, useful for some filetypes
augroup trim_whitespace
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

" Set options for markdown files
augroup markdown_options
  autocmd!
  autocmd BufRead,BufNewFile *.md call SetMarkdownOptions()

  function! SetMarkdownOptions()
    setlocal spell
    setlocal fo+=t
    setlocal fo-=l
    setlocal textwidth=80
  endfunction
augroup END
