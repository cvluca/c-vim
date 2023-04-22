fu! LoadConfig(file)
  if filereadable(a:file)
    execute 'source' a:file
  endif
endf

call LoadConfig(g:c_vim_config_path . 'options.vim')

call plug#begin()

call LoadConfig(g:c_vim_config_path . 'plug.vim')

call plug#end()

call LoadConfig(g:c_vim_config_path . 'base.vim')

for plugin in split(glob(g:c_vim_config_path . g:c_vim_plugins_config_dir . '*.vim'), '\n')
  if isdirectory(g:c_vim_plugged_path . fnamemodify(plugin, ':t:r'))
    call LoadConfig(plugin)
  endif
endfor
