augroup mycppfiles
  au!
  au BufEnter *.h let b:fswitchdst  = 'cpp,cc,c'
  au BufEnter *.h let b:fswitchlocs = 'reg:/include/src/,reg:/include.*/src/'
  au BufEnter *.hpp let b:fswitchdst  = 'cpp,cc,cxx'
  au BufEnter *.hpp let b:fswitchlocs = 'reg:/include/src/,reg:/include.*/src/'
  au BufEnter *.hxx let b:fswitchdst  = 'cxx,cc,cpp'
  au BufEnter *.hxx let b:fswitchlocs = 'reg:/include/src/,reg:/include.*/src/'
  au BufEnter *.c let b:fswitchdst  = 'h'
  au BufEnter *.c let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/**|,../include'
  au BufEnter *.cpp let b:fswitchdst  = 'hpp,h,hxx'
  au BufEnter *.cpp let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/**|,../include'
  au BufEnter *.cxx let b:fswitchdst  = 'hxx,h,hpp'
  au BufEnter *.cxx let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/**|,../include'
  au BufEnter *.cc let b:fswitchdst  = 'hpp,h,hxx'
  au BufEnter *.cc let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/**|,../include'
augroup END

nmap <silent> gs :FSHere<CR>
