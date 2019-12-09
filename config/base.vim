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

set guioptions=T
set backspace=indent,eol,start

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Remember info about open buffers on close
set nocompatible
execute "set viminfo='1000,:1000,n" . g:c_vim_source_path . g:c_vim_viminfo

" Use spaces insteaad of tabs
set expandtab
execute "set tabstop=" . g:c_vim_tabsize
execute "set shiftwidth=" . g:c_vim_tabsize
execute "set softtabstop=" . g:c_vim_tabsize

" Show matching brackets when text indicator is over them
set showmatch

" cursor
set cuc
set cul

set ttyfast
set lazyredraw

" Use Doroid Sans Mono as the gui font
set guifont=Droid\ Sans\ Mono\ Nerd\ Font\ Complete:h11

" Always show the status line
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" Check filetype
filetype on

" Enable filetype plugins
filetype plugin indent on

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

set list
"set listchars=tab:‣\ ,trail:·,precedes:«,extends:»
set listchars=tab:→\ ,trail:·,precedes:«,extends:»

set autochdir

" change leader to space
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" disable swapfile
set noswapfile

nmap <C-x> :bp\|bd #<CR>

au BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
