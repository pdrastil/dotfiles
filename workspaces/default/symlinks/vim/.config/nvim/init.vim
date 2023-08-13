if filereadable('/usr/local/opt/fzf')
  set rtp+=/usr/local/opt/fzf
elseif filereadable('/opt/homebrew/opt/fzf')
  set rtp+=/opt/homebrew/opt/fzf
endif

let g:nvim_config_files = [
  \ 'plugins.vim',
  \ 'options.vim',
  \ 'commands.vim',
  \ 'mappings.vim',
  \ ]

let g:nvim_config_root = expand('<sfile>:p:h')
for s:fname in g:nvim_config_files
  execute printf('source %s/core/%s', g:nvim_config_root, s:fname)
endfor
