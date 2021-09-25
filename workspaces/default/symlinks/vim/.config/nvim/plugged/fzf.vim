" #############################################################
" # Plugin: FZF                                               #
" # Link: https://github.com/junegunn/fzf.vim                 #
" #############################################################




if has("nvim")
  au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au! FileType fzf tunmap <buffer> <Esc>
endif



" Custom function
let s:is_win = has('win32') || has('win64')
function! s:warn(message)
  echohl WarningMsg
  echom a:message
  echohl None
  return 0
endfunction

function! s:shortpath()
  let short = fnamemodify(getcwd(), ':~:.')
  if !has('win32unix')
    let short = pathshorten(short)
  endif
  let slash = (s:is_win && !&shellslash) ? '\' : '/'
  return empty(short) ? '~'.slash : short . (short =~ escape(slash, '\').'$' ? '' : slash)
endfunction

function! FzfIcons(dir,...)
  let args = {}
  if !empty(a:dir)
    if !isdirectory(expand(a:dir))
      return s:warn('Invalid directory')
    endif
    let slash = (s:is_win && !&shellslash) ? '\\' : '/'
    let dir = substitute(a:dir, '[/\\]*$', slash, '')
    let args.dir = dir
  else
    let dir = s:shortpath()
  endif


  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  " Add icon to fzf item
  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
    \ 'source': <sid>files(),
    \ 'sink': function('s:edit_file'),
    \ 'options': '-m ',
    \ 'down': '40%'
  \ })




  " source =
  " sink = reference funcion to process each selected item
"   call fzf#run({
"         \ 'source': <sid>files(),
"         \ 'sink':   function('s:edit_file'),
"         \ 'options': '-m ' . l:fzf_files_options,
"         \ 'down':    '40%' })

endfunction

"command! -bang -nargs=? -complete=dir IconFiles
"  \ call FzfIcons(<q-args>,fzf#vim#with_preview(),<bang>0)

" Use preview for :Files command
"command! -bang -nargs=? -complete=dir Files
"  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)




" " ripgrep integration -> should be improved
" if executable('rg')
"   let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
"   set grepprg=rg\ --vimgrep
"   command! -bang -nargs=* Rg
"     \ call fzf#vim#grep(
"     \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color=always '.shellescape(<q-args>).'| tr -d "\017"', 1,
"     \   fzf#vim#with_preview(), <bang>0)
" endif


" " Add preview to Files command
" command! -bang -nargs=? -complete=dir Files
"   \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline', '--preview', 'bat {}']}), <bang>0)

" nnoremap <silent> <leader>e :call Fzf_dev()<CR>

" " Files + devicons
" function! Fzf_dev()
"   let l:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color=always {2..-1} | head -'.&lines.'"'

"   function! s:files()
"     let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
"     return s:prepend_icon(l:files)
"   endfunction

"   function! s:prepend_icon(candidates)
"     let l:result = []
"     for l:candidate in a:candidates
"       let l:filename = fnamemodify(l:candidate, ':p:t')
"       let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
"       call add(l:result, printf('%s %s', l:icon, l:candidate))
"     endfor

"     return l:result
"   endfunction

"   function! s:edit_file(item)
"     let l:pos = stridx(a:item, ' ')
"     let l:file_path = a:item[pos+1:-1]
"     execute 'silent e' l:file_path
"   endfunction

"   call fzf#run({
"         \ 'source': <sid>files(),
"         \ 'sink':   function('s:edit_file'),
"         \ 'options': '-m ' . l:fzf_files_options,
"         \ 'down':    '40%' })
" endfunction
