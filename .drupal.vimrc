" Put the following in your .vimrc
" You can then import all Drupal macros by typing F2, #d, enter
"
" noremap <leader><F2>#d<CR> :source ~/.drupal_vim/.drupal.vimrc<CR>:filetype detect<CR>:exe ":echo 'Drupal Vim loaded'"<CR>

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
    autocmd!
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
  " Insert fragment file, checking to see if we're in a custom location
  let s:drupal_vim_hooks = "~/.drupal_vim"
  if exists("g:drupal_vim_dir")
    let s:drupal_vim_hooks = g:drupal_vim_dir
  endif
  exe ":read " . s:drupal_vim_hooks . "/" . a:direc .  "/" . a:file .  ".txt"

  " Replace hook name with module name
  " Can't always autodetect file name e.g. if file not saved
  let s:name = expand("%:t:r")
  if (s:name == "")
    let s:name = input("Module name? ")
  endif
  exe ".,$s/HOOK/" . s:name . "/"
endfunction

" Hook template mappings
noremap <leader><F2>block<CR> :call <SID>InsertHook("block")<CR>
noremap <leader><F2>bi<CR> :call <SID>InsertHook("block_info")<CR>
noremap <leader><F2>bv<CR> :call <SID>InsertHook("block_view")<CR>
noremap <leader><F2>cron<CR> :call <SID>InsertHook("cron")<CR>
noremap <leader><F2>fa<CR> :call <SID>InsertHook("form_alter")<CR>
noremap <leader><F2>help<CR> :call <SID>InsertHook("help")<CR>
noremap <leader><F2>init<CR> :call <SID>InsertHook("init")<CR>
noremap <leader><F2>install<CR> :call <SID>InsertHook("install")<CR>
noremap <leader><F2>menu<CR> :call <SID>InsertHook("menu")<CR>
noremap <leader><F2>napi<CR> :call <SID>InsertHook("nodeapi")<CR>
noremap <leader><F2>perm<CR> :call <SID>InsertHook("permission")<CR>
noremap <leader><F2>d6perm<CR> :call <SID>InsertHook("perm")<CR>
noremap <leader><F2>schema<CR> :call <SID>InsertHook("schema")<CR>
noremap <leader><F2>ta<CR> :call <SID>InsertHook("theme_registry_alter")<CR>
noremap <leader><F2>tra<CR> :call <SID>InsertHook("theme_registry_alter")<CR>
noremap <leader><F2>theme<CR> :call <SID>InsertHook("theme")<CR>
noremap <leader><F2>uninstall<CR> :call <SID>InsertHook("uninstall")<CR>
noremap <leader><F2>user<CR> :call <SID>InsertHook("user")<CR>

" Preprocess template mappings
noremap <leader><F2>pp<CR> :call <SID>InsertPP("default")<CR>
noremap <leader><F2>ppp<CR> :call <SID>InsertPP("page")<CR>
noremap <leader><F2>ppn<CR> :call <SID>InsertPP("node")<CR>
noremap <leader><F2>ppb<CR> :call <SID>InsertPP("block")<CR>


" Fragments of useful code
noremap <leader><F2>f<CR> :read ~/.drupal_vim/fragments/top.txt<CR>:set syntax=php<CR> kdd /HOOK<CR>4xa
noremap <leader><F2>fn<CR> :read ~/.drupal_vim/fragments/function.txt<CR>:set syntax=php<CR> kdd /HOOK<CR>4xa
noremap <leader><F2>i<CR> :read ~/.drupal_vim/fragments/info.txt<CR>:set syntax=php<CR> kdd /HOOK<CR>4xa


" %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
" And finally...

" It will generally do no harm to auto-highlight the current file
" Filetype autodetect will switch auto-highlighting back if we're badly wrong
set syntax=php
filetype detect

" Say hello, .drupal.vimrc !
echo 'Drupal Vim loaded'
