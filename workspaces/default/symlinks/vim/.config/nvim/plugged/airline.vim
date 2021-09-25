" #############################################################
" # Plugin: Airline status bar                                #
" # Link: https://github.com/vim-airline/vim-airline          #
" #############################################################

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
