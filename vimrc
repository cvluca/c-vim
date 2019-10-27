let g:c_vim_source_path = fnamemodify(expand('<sfile>'), ':h').'/.vim'
let g:c_vim_viminfo = '/.viminfo'

if filereadable(g:c_vim_source_path . '/config/main.vim')
  execute 'source' g:c_vim_source_path . '/config/main.vim'
endif
