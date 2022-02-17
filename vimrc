if has('win32')
  let g:c_vim_source_path = fnamemodify(expand('<sfile>'), ':h').'\vimfiles'
  let g:c_vim_viminfo = '\.viminfo'
  let g:c_vim_config_path = g:c_vim_source_path . '\config\'
  let g:c_vim_plugged_path = g:c_vim_source_path . '\plugged\'
  let g:c_vim_plugins_config_dir = 'plugins\'
else
  let g:c_vim_source_path = fnamemodify(expand('<sfile>'), ':h').'/.vim'
  let g:c_vim_viminfo = g:c_vim_source_path . '/.viminfo'
  let g:c_vim_config_path = g:c_vim_source_path . '/config/'
  let g:c_vim_plugged_path = g:c_vim_source_path . '/plugged/'
  let g:c_vim_plugins_config_dir = 'plugins/'
endif

if filereadable(g:c_vim_config_path . 'main.vim')
  execute 'source' g:c_vim_config_path . 'main.vim'
endif
