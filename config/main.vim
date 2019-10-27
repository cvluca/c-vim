fu! LoadConfig(file)
  let config_file = g:c_vim_source_path . '/config/' . a:file
  if filereadable(config_file)
    execute 'source' config_file
  endif
endf

call LoadConfig('options.vim')

call plug#begin()

call LoadConfig('plug.vim')

call plug#end()

call LoadConfig('base.vim')

let plugins_config_source = [
  \'nerdtree',
  \'nerdtree-git-plugin',
  \'nerdcommenter',
  \'gruvbox',
  \'vim-airline',
  \'vim-airline-themes',
  \'vim-better-whitespace',
  \'vim-easymotion',
  \'coc',
  \'auto-pairs',
  \'vim-gitgutter',
  \]

for plugin in plugins_config_source
  call LoadConfig('plugins/' . plugin . '.vim')
endfor
