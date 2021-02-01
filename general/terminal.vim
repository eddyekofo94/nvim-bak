" Terminal configs

augroup TerminalExit
    au!
    autocmd TermOpen * set shell=/usr/local/bin/fish
    autocmd TermOpen  * startinsert
    autocmd TermOpen,TermEnter, * set norelativenumber
    autocmd TermOpen,TermEnter,TermChanged * set nonumber
augroup END

nnoremap <silent> <C-w><C-t> :belowright vsplit<CR>:term<CR>
" For exiting the termial mode. Better than the default config
tnoremap <Esc> <C-\><C-n><CR>

