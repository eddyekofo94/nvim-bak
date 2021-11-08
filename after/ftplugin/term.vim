setlocal norelativenumber
setlocal nonumber

setlocal scrolloff=0

augroup terminal_enter
    autocmd!
    autocmd TermOpen  * startinsert
    autocmd TermEnter * setlocal nocursorline nocursorcolumn
    autocmd TermOpen * :call clearmatches()
augroup END

tnoremap ,reload %load_ext autoreload<CR>%autoreload 2<CR>

" For exiting the termial mode. Better than the default config
tnoremap <Esc> <C-\><C-n><CR>

