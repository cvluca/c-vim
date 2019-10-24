let g:c_vim_source_path = fnamemodify(expand('<sfile>'), ':h')
let g:c_vim_tabsize = 2
let g:c_vim_viminfo = '/shada/main.shada'
let g:enable_coc_plugins = 1

if filereadable(g:c_vim_source_path . '/config/main.vim')
  execute 'source' g:c_vim_source_path . '/config/main.vim'
endif
