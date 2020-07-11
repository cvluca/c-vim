function! FZFOpen(command_str)
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
  endif
  exe a:command_str
endfunction

nnoremap <silent> <leader>b :call FZFOpen(':Buffers')<CR>
nnoremap <silent> <leader>f :call FZFOpen(':Files')<CR>

if g:c_vim_grep == 'rg'
  nnoremap <silent> <leader>g :call FZFOpen(':Rg')<CR>
  nnoremap <silent> <leader>G :call FZFOpen(':Rg <C-R><C-W>')<CR>
  let $FZF_DEFAULT_COMMAND = 'rg --files | rg --smart-case ""'
endif

if g:c_vim_grep == 'ag'
  nnoremap <silent> <leader>g :call FZFOpen(':Ag')<CR>
  nnoremap <silent> <leader>G :call FZFOpen(':Ag <C-R><C-W>')<CR>
  let $FZF_DEFAULT_COMMAND = 'ag -g ""'
endif
