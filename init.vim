let g:c_vim_source_path = stdpath('config')

fu! ToShellSlash(str)
  return substitute(a:str, "\\", "/", "g")
endf

fu! FromShellSlash(str)
  return substitute(a:str, "/", "\\", "g")
endf

let g:c_vim_viminfo = g:c_vim_source_path . '/shada/main.shada'
let g:c_vim_config_path = g:c_vim_source_path . '/config/'
let g:c_vim_plugged_path = g:c_vim_source_path . '/plugged/'
let g:c_vim_plugins_config_dir = 'plugins/'

if has('win32')
  let g:c_vim_viminfo = ToShellSlash(g:c_vim_viminfo)
  let g:c_vim_config_path = FromShellSlash(g:c_vim_config_path)
  let g:c_vim_plugged_path = FromShellSlash(g:c_vim_plugged_path)
  let g:c_vim_plugins_config_dir = FromShellSlash(g:c_vim_plugins_config_dir)
endif

if filereadable(g:c_vim_config_path . 'main.vim')
  execute 'source' g:c_vim_config_path . 'main.vim'
endif
