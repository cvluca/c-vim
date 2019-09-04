fu! LoadConfig(file)
  execute 'source' g:c_vim_source_path . '/config/' . a:file
endf

call plug#begin()

call LoadConfig('plug.vim')

call plug#end()

call LoadConfig('base.vim')

let plugins_config_source = [
  \'nerdtree',
  \'nerdtree-git-plugin',
  \'nerdcommenter',
  \'solarized',
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
