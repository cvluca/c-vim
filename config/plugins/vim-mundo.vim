" Enable persistent undo so that undo history persists across vim sessions
set undofile
if has('win32')
  let undodir = g:c_vim_source_path . '\undo'
else
  let undodir = g:c_vim_source_path . '/undo'
endif
execute "set undodir=" . undodir
nnoremap <Leader><Leader>u :MundoToggle<CR>

let g:mundo_width = 60
let g:mundo_preview_height = 40
let g:mundo_right = 1

execute "silent !mkdir -p " . undodir
