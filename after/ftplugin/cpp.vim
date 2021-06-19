setlocal shiftwidth=4
setlocal commentstring=//%s

" Jump to a file whose extension corresponds to the extension of the current
" file. The `tags' file, created with:
" $ ctags --extra=+f -R .
" has to be present in the current directory.
function! JumpToCorrespondingFile()
    let l:extensions = { 'c': 'h', 'h': 'c', 'cpp': 'hpp', 'hpp': 'cpp' }
    let l:fe = expand('%:e')
    if has_key(l:extensions, l:fe)
        execute ':tag ' . expand('%:t:r') . '.' . l:extensions[l:fe]
    else
        call PrintError(">>> Corresponding extension for '" . l:fe . "' is not specified")
    endif
endfunct

" jump to a file with the corresponding extension (<SHIFT-f>
nnoremap <S-f> :call JumpToCorrespondingFile()<CR>

" Print error message.
function! PrintError(msg) abort
    execute 'normal! \<Esc>'
    echohl ErrorMsg
    echomsg a:msg
    echohl None
endfunction
