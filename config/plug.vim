let g:c_vim_plugins = [
  \['scrooloose/nerdtree'],
  \['scrooloose/nerdcommenter'],
  \['tpope/vim-commentary'],
  \['Xuyuanp/nerdtree-git-plugin'],
  \['vim-airline/vim-airline'],
  \['vim-airline/vim-airline-themes'],
  \['ntpeters/vim-better-whitespace'],
  \['easymotion/vim-easymotion'],
  \['jiangmiao/auto-pairs'],
  \['airblade/vim-gitgutter'],
  \['rhysd/vim-clang-format'],
  \]

let coc_plugins = [
  \['neoclide/coc.nvim', {'do': { -> coc#util#install()}}],
  \['neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-java', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-vetur', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}],
  \['fannheyward/coc-texlab', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-emmet', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-yank', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}],
  \]

for plugin in g:c_vim_plugins + coc_plugins
  if len(plugin) == 1
    Plug plugin[0]
  else
    Plug plugin[0], plugin[1]
  endif
endfor
