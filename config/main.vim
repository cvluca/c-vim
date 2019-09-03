fu! LoadConfig(file)
  execute 'source' g:c_vim_source_path . '/config/' . a:file
endf

call plug#begin()

call LoadConfig('plug.vim')

call plug#end()

call LoadConfig('base.vim')

let plugins_config_source = [
  \'nerdtree.vim',
  \'solarized.vim',
  \'coc.vim'
\]

for plugin in plugins_config_source
  call LoadConfig('plugins/' . plugin)
endfor