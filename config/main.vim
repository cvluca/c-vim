call plug#begin()

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/plug.vim'

call plug#end()

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/plugins/main.vim'

" Show line number
set number

" Show relative line number
set relativenumber

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf-8
set fileencoding=utf-8

" Autoindent
set autoindent
set cindent

" jk to Esc
inoremap jk <Esc>