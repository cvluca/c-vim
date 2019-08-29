set rtp+=~/.vim/plugins/vim-colors-solarized
call plug#begin()

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/plug.vim'

call plug#end()

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/base.vim'

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/plugins/main.vim'