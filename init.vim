let g:c_vim_source_path = fnamemodify(expand('<sfile>'), ':h')

if has('win32')
  set shellslash
  let g:c_vim_viminfo = fnamemodify(expand('$:p'), ':h') . '/shada/main.shada'
  set noshellslash
  let g:c_vim_config_path = g:c_vim_source_path . '\config\'
  let g:c_vim_plugged_path = g:c_vim_source_path . '\plugged\'
  let g:c_vim_plugins_config_dir = 'plugins\'
else
  let g:c_vim_viminfo = g:c_vim_source_path . '/shada/main.shada'
  let g:c_vim_config_path = g:c_vim_source_path . '/config/'
  let g:c_vim_plugged_path = g:c_vim_source_path . '/plugged/'
  let g:c_vim_plugins_config_dir = 'plugins/'
endif

if filereadable(g:c_vim_config_path . 'main.vim')
  execute 'source' g:c_vim_config_path . 'main.vim'
endif
