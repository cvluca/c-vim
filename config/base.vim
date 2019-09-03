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

set backspace=indent,eol,start

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Remember info about open buffers on close
set nocompatible
set viminfo='1000,:1000,n~/.vim/.viminfo
