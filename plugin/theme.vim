
" Themes: This is is where the the colours etc are set

"colorscheme nord
" Enable italics, Make sure this is immediately after colorscheme
" https://stackoverflow.com/questions/3494435/vimrc-make-comments-italic
highlight Comment cterm=italic gui=italic
set background=dark

if !has('gui_running')
  set t_Co=256
endif

"let g:spaceline_colorscheme = 'nord'
"let g:spaceline_seperate_style = 'none'

" Lightline: Use it or don't but remove it sometime
"let g:lightline = {
"      \ 'colorscheme': 'nord',
      "\ }
