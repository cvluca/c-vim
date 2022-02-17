fu! LoadConfig(file)
  if filereadable(g:c_vim_config_path . a:file)
    execute 'source' g:c_vim_config_path . a:file
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
  if isdirectory(g:c_vim_plugged_path . plugin)
    call LoadConfig(g:c_vim_plugins_config_dir . plugin . '.vim')
  endif
endfor
