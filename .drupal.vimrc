" Put the following in your .vimrc
" You can then import all Drupal macros by typing F2, #d, enter
"
" noremap <buffer> <F2>#d<CR> :source ~/.drupal_vim/.drupal.vimrc<CR>:filetype detect<CR>:exe ":echo 'Drupal Vim loaded'"<CR>

" %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
" Settings

" From http://drupal.org/node/29325
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent

" Auto-highlight .module and .install files
if has("autocmd")
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
  augroup END
endif
syntax on


" From http://www.federicopistono.org/content/vimrc_for_drupal_developers
" Highlight chars that go over the 80-column limit
:highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
:match OverLength '\%81v.*'

" Highlight redundant whitespaces and tabs.
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t\|\t/

let php_sql_query = 1
let php_baselib = 1
let php_htmlInStrings = 1
let php_folding = 1

" %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
" Hook templates and file fragments

" Function to insert a hook template
function! s:InsertHook(hook)
  " Insert
  exe "read ~/.drupal_vim/hooks/" . a:hook .  ".txt"
  " Replace hook name with module name
  " Can't always autodetect file name e.g. if file not saved
  let s:name = input("Module name? ")
  exe ".,$s/HOOK/" . s:name . "/"
endfunction

" Hook template mappings
noremap <buffer> <F2>block<CR> :call <SID>InsertHook("block")<CR>
noremap <buffer> <F2>menu<CR> :call <SID>InsertHook("menu")<CR>
noremap <buffer> <F2>init<CR> :call <SID>InsertHook("init")<CR>

" Fragments of useful code
noremap <buffer> <F2>#f<CR> :read ~/.drupal_vim/fragments/top.txt<CR>:set syntax=php<CR> kdd /HOOK<CR>4xa

" %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
" And finally...

" It will generally do no harm to auto-highlight the current file
" Filetype autodetect will switch auto-highlighting back if we're badly wrong
set syntax=php
filetype detect

" Say hello, .drupal.vimrc !
echo 'Drupal Vim loaded'
