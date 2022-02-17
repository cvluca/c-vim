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
  \['neoclide/coc.nvim', {'branch': 'release'}],
  \['ryanoasis/vim-devicons'],
  \['junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }],
  \['junegunn/fzf.vim'],
  \['simnalamburt/vim-mundo'],
  \['fatih/vim-go'],
  \['derekwyatt/vim-fswitch'],
  \['jackguo380/vim-lsp-cxx-highlight'],
  \]

let c_vim_plugins_with_py = [
  \['puremourning/vimspector'],
  \]

let optional_plugins = [
  \['mlr-msft/vim-loves-dafny', {'for': 'dafny'}],
  \['cvluca/vim-seL4'],
  \]

if g:enable_coc_plugins == 1
  let g:coc_global_extensions=[
    \'coc-tsserver',
    \'coc-css',
    \'coc-java',
    \'coc-vetur',
    \'coc-snippets',
    \'coc-highlight',
    \'coc-python',
    \'coc-rls',
    \'coc-emmet',
    \'coc-yank',
    \'coc-lists',
    \'coc-git',
    \'coc-json',
    \'coc-clangd',
    \'coc-cmake',
    \'coc-powershell'
    \]
endif

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

if g:enable_optional_plugins == 1
  call LoadPlugins(optional_plugins)
endif

if has('python3')
  call LoadPlugins(c_vim_plugins_with_py)
endif
