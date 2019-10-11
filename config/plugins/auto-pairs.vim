" input: if(a[3)
" output: if(a[3])| (In Fly Mode)
" output: if(a[3)]) (Without Fly Mode)

" input:
" {
"     hello();|
"     world();
" }

" (press } at |)

" output:
" {
"     hello();
"     world();
" }|

" (then press <C-b> at | to do backinsert)
" output:
" {
"     hello();}|
"     world();
" }
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = '<C-b>'

" Fast wrap the word. all pairs will be consider as a block (include <>).
" (|)'hello' after fast wrap at |, the word will be ('hello')
" (|)<hello> after fast wrap at |, the word will be (<hello>)
let g:AutoPairsShortcutFastWrap = '<C-e>'

" Jump to the next closed pair
let g:AutoPairsShortcutJump = '<C-n>'

" The shortcut to toggle autopairs.
let g:AutoPairsShortcutToggle = '<C-p>'
