
" Themes: This is is where the the colours etc are set

colorscheme nord
" Enable italics, Make sure this is immediately after colorscheme
" https://stackoverflow.com/questions/3494435/vimrc-make-comments-italic
highlight Comment cterm=italic gui=italic
set background=dark

if !has('gui_running')
  set t_Co=256
endif

" Plugin: Galaxyline -------------------------- {{{

function! ConfigStatusLine()
  lua require('plugins.nvcodeline')
endfunction

augroup status_line_init
  autocmd!
  autocmd VimEnter * call ConfigStatusLine()
augroup END

lua require'colorizer'.setup()
" }}}
