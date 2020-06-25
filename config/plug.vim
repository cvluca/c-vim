let c_vim_plugins = [
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
  \['morhetz/gruvbox'],
  \['neoclide/coc.nvim', {'do': { -> coc#util#install()}}],
  \['ryanoasis/vim-devicons'],
  \['junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }],
  \['junegunn/fzf.vim'],
  \['simnalamburt/vim-mundo'],
  \['fatih/vim-go'],
  \]

let coc_plugins = [
  \['neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-java', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-vetur', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-emmet', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-yank', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}],
  \['neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}],
  \['clangd/coc-clangd', {'do': 'yarn install --frozen-lockfile'}],
  \['jackguo380/vim-lsp-cxx-highlight'],
  \]

let optional_plugins = [
  \['mlr-msft/vim-loves-dafny', {'for': 'dafny'}],
  \]

fu! LoadPlugins(plugins)
  for plugin in a:plugins
    if len(plugin) == 1
      Plug plugin[0]
    else
      Plug plugin[0], plugin[1]
    endif
  endfor
endf

call LoadPlugins(c_vim_plugins)

if g:enable_coc_plugins == 1
  call LoadPlugins(coc_plugins)
endif

if g:enable_optional_plugins == 1
  call LoadPlugins(optional_plugins)
endif
