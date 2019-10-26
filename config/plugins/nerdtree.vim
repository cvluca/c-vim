map <F4> :NERDTreeToggle<CR>
imap <F4> <ESC>:NERDTreeToggle<CR>

autocmd StdinReadPre * let s:std_in=1

if g:nerdtree_open == 1
  if winwidth('%') >= 160 && argc() != 0
    autocmd VimEnter *
      \ if argc() == 1
      \ && isdirectory(argv()[0])
      \ && !exists("s:std_in")
      \| exe 'NERDTree' argv()[0]
      \| wincmd p
      \| ene
      \| exe 'cd '.argv()[0]
      \| else
      \| NERDTree
      \| wincmd p
      \| endif
  else
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  endif

  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endif

autocmd FileType nerdtree nmap <buffer> <left> o
autocmd FileType nerdtree nmap <buffer> <right> o
autocmd FileType nerdtree nmap <buffer> h o
autocmd FileType nerdtree nmap <buffer> l o
autocmd FileType nerdtree nmap <buffer> <Tab> C

let NERDTreeShowHidden=1
