function! FZFOpen(command_str)
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
  endif
  exe a:command_str
endfunction

nnoremap <silent> <leader>b :call FZFOpen(':Buffers')<CR>
nnoremap <silent> <leader>g :call FZFOpen(':Ag')<CR>
nnoremap <silent> <leader>G :call FZFOpen(':Ag <C-R><C-W>')<CR>
nnoremap <silent> <leader>f :call FZFOpen(':Files')<CR>
