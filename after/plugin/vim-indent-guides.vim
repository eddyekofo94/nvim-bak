let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1

augroup INDENT_GUIDES
  au!
  autocmd FileType,Colorscheme cpp,c,rust,lua,vim,python,javascript :hi IndentGuidesOdd  guibg=#4c566a   ctermbg=3
  autocmd FileType,Colorscheme cpp,c,rust,lua,vim,python,javascript :hi IndentGuidesEven guibg=#5a5d63 ctermbg=4
augroup end
