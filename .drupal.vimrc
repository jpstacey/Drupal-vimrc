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

function! s:InsertHook(hook)
  exe ':call <SID>InsertFile("hooks","' . a:hook . '")'
endfunction

function! s:InsertPP(pp)
  exe ':call <SID>InsertFile("preprocess","' . a:pp . '")'
endfunction


" Function to insert a hook template
function! s:InsertFile(direc,file)
  " Insert
  exe ":read ~/.drupal_vim/" . a:direc .  "/" . a:file .  ".txt"
  " Replace hook name with module name
  " Can't always autodetect file name e.g. if file not saved
  let s:name = input("Module name? ")
  exe ".,$s/HOOK/" . s:name . "/"
endfunction

" Hook template mappings
noremap <buffer> <F2>block<CR> :call <SID>InsertHook("block")<CR>
noremap <buffer> <F2>fa<CR> :call <SID>InsertHook("form_alter")<CR>
noremap <buffer> <F2>init<CR> :call <SID>InsertHook("init")<CR>
noremap <buffer> <F2>menu<CR> :call <SID>InsertHook("menu")<CR>
noremap <buffer> <F2>napi<CR> :call <SID>InsertHook("nodeapi")<CR>
noremap <buffer> <F2>perm<CR> :call <SID>InsertHook("perm")<CR>
noremap <buffer> <F2>theme<CR> :call <SID>InsertHook("theme")<CR>
noremap <buffer> <F2>user<CR> :call <SID>InsertHook("user")<CR>

" Preprocess template mappings
noremap <buffer> <F2>pp<CR> :call <SID>InsertPP("default")<CR>
noremap <buffer> <F2>ppp<CR> :call <SID>InsertPP("page")<CR>
noremap <buffer> <F2>ppn<CR> :call <SID>InsertPP("node")<CR>
noremap <buffer> <F2>ppb<CR> :call <SID>InsertPP("block")<CR>


" Fragments of useful code
noremap <buffer> <F2>#f<CR> :read ~/.drupal_vim/fragments/top.txt<CR>:set syntax=php<CR> kdd /HOOK<CR>4xa
noremap <buffer> <F2>#fn<CR> :read ~/.drupal_vim/fragments/function.txt<CR>:set syntax=php<CR> kdd /HOOK<CR>4xa
noremap <buffer> <F2>#i<CR> :read ~/.drupal_vim/fragments/info.txt<CR>:set syntax=php<CR> kdd /HOOK<CR>4xa


" %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
" And finally...

" It will generally do no harm to auto-highlight the current file
" Filetype autodetect will switch auto-highlighting back if we're badly wrong
set syntax=php
filetype detect

" Say hello, .drupal.vimrc !
echo 'Drupal Vim loaded'
