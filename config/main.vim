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
  \'coc.nvim',
  \'auto-pairs',
  \'vim-gitgutter',
  \'vim-commentary',
  \'fzf.vim',
  \'vim-mundo',
  \'vim-fswitch',
  \'vimspector',
  \]

for plugin in plugins_config_source
  let source = g:c_vim_source_path . '/plugged/' . plugin
  if has('win32')
    call LoadConfig('plugins/' . plugin . '.vim')
  elseif isdirectory(source)
    call LoadConfig('plugins/' . plugin . '.vim')
  endif
endfor
