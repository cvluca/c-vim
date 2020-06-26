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
else
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
endif

autocmd FileType nerdtree nmap <buffer> <left> o
autocmd FileType nerdtree nmap <buffer> <right> o
autocmd FileType nerdtree nmap <buffer> h o
autocmd FileType nerdtree nmap <buffer> l o
autocmd FileType nerdtree nmap <buffer> <Tab> C

let NERDTreeShowHidden=1

" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! IsCocListOpen()
  return expand('%') =~ 'list:///*'
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && !IsCocListOpen() && strlen(expand('%')) > 0 && !&diff && bufname('%') !~# 'NERD_tree'
    try
      NERDTreeFind
      if bufname('%') =~# 'NERD_tree'
        setlocal cursorline
        wincmd p
      endif
    endtry
  endif
endfunction

autocmd BufEnter * silent! call SyncTree()

if IsNERDTreeOpen()
  autocmd BufWritePost * NERDTreeFocus | execute 'normal R' | wincmd p
endif
