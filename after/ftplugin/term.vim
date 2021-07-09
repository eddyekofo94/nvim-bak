setlocal norelativenumber
setlocal nonumber

setlocal scrolloff=0

augroup terminal_enter
    autocmd!
    autocmd TermEnter * setlocal nocursorline nocursorcolumn
    autocmd TermOpen * :call clearmatches()
augroup END

tnoremap ,reload %load_ext autoreload<CR>%autoreload 2<CR>
