" #############################################################
" Plugin: NerdTree
" Link: https://github.com/preservim/nerdtree
" #############################################################
" Set
let g:NERDTreeWinPos="right"
let g:NERDTreeQuitOnOpen="1"
let NERDTreeShowHidden=0

" ---[ Keybings ]----------------------------------------------
"noremap <C-n> :NERDTreeToggle<cr>
noremap <C-g> :NERDTreeFind<cr>


" turn terminal to normal mode with escape
" tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
"au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
"nnoremap <c-n> :call OpenTerminal()<CR>

tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l


"let g:NERDTreeShowHidden = 1
"let g:NERDTreeMinimalUI = 1
"let g:NERDTreeIgnore = []
"let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
"nnoremap <silent> <C-b> :NERDTreeToggle<CR>
