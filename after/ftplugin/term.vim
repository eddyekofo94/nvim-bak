setlocal norelativenumber
setlocal nonumber
setlocal modifiable
setlocal scrolloff=0
setlocal nobuflisted

augroup terminal_enter
    autocmd!
    autocmd TermOpen  * startinsert
    autocmd TermEnter * setlocal nocursorline nocursorcolumn nobuflisted
    autocmd TermOpen * :call clearmatches()
augroup END

tnoremap ,reload %load_ext autoreload<CR>%autoreload 2<CR>

" For exiting the termial mode. Better than the default config
tnoremap <Esc> <C-\><C-n><CR>
