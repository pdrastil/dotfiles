" #############################################################
" # Custom key bindings                                       #
" #############################################################
scriptencoding utf-8

" Map <leader> to ',' from default '\' for extra key combinations
" Leader has to be specified early to activate additional mappings
let mapleader = ","

" Remap 0 to first non-blank character
map 0 ^

" Map <Space> to search (/)
nmap <space> /
" Map Alt + <Space> to backwards search (?)
nmap <A-space> ?

" Move to previous and next whitespace
nnoremap ]w :NextTrailingWhitespace<CR>
nnoremap [w :PrevTrailingWhitespace<CR>

" Smart movement between windows
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" Based on https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
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
"nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Useful mappings for managing tabs
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tq :tabclose<cr>

" Toggle between current and the last accessed tab
let g:lasttab = 1
nmap <leader>tl : exe "tabn " . g:lasttab<cr>
augroup tab_last_toggle
  autocmd!
  autocmd TabLeave * let g:lasttab = tabpagenr()
augroup END

" Open a new tab with the current buffer path
" Useful when editing files in the same directory
nnoremap <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/
