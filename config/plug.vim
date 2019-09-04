let g:c_vim_plugins = [
  \['scrooloose/nerdtree'],
  \['scrooloose/nerdcommenter'],
  \['tpope/vim-commentary'],
  \['Xuyuanp/nerdtree-git-plugin'],
  \['neoclide/coc.nvim', {'branch': 'release'}],
  \['vim-airline/vim-airline'],
  \['vim-airline/vim-airline-themes'],
  \['ntpeters/vim-better-whitespace'],
  \['easymotion/vim-easymotion'],
  \['jiangmiao/auto-pairs'],
  \['airblade/vim-gitgutter'],
  \]

for plugin in g:c_vim_plugins
  let list_len = len(plugin)
  if len(plugin) == 1
    Plug plugin[0]
  else
    Plug plugin[0], plugin[1]
  endif
endfor
