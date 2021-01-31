let g:term_buf = 0
let g:term_win = 0
function! Termtoggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            exec ":term"
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        " if mode() != 'i' && mode() != 't'
          " call feedkeys('i')
        " endif
        let g:term_win = win_getid()
    endif
endfunction
autocmd sessionloadpost *.* silent call Settermid()
function! Settermid()
  let g:term_win =  bufwinid("!/usr/local/bin/fish")
endfunction

" toggle terminal on/off
nmap ` :call Termtoggle(12)<cr>
imap ` <esc>:call Termtoggle(12)<cr>
tmap ` <c-\><c-n>:call Termtoggle(12)<cr>

" terminal go back to normal mode
tnoremap <esc> <c-\><c-n>
tnoremap :q! <c-\><c-n>:q!<cr>
