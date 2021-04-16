set backspace=indent,eol,start " Backspace over newlines
" settings for hidden chars
" what particular chars they are displayed with
set listchars=eol:↵,nbsp:␣,extends:…,precedes:…

" Maximum chars colour
function! MaxLineChars()
    let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endfunction

augroup MAX_CHARS_COLUMN
    autocmd!
    autocmd FileType cpp,h,hpp,cxx,cs,fish,shell,bash,rust,ts,java,php,lua,javascript :call MaxLineChars()
    autocmd BufLeave * :call clearmatches()
  augroup end

" Remove whitespace
function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup THE_ED_CLEAN
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup end

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" You can't stop me
cmap w!! w !sudo tee %

" Override the default Red & White
highlight ErrorMsg guibg=NONE guifg=#fa616a
highlight Tooltip guibg=NONE guifg=#88c0d0
highlight WarningMsg guibg=NONE guifg=#ffd394
