
" Themes: This is is where the the colours etc are set

colorscheme nord
" colorscheme gruvbox
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

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500}
augroup END

hi Visual  cterm=reverse ctermbg=NONE guibg=#4c566a  guifg=#d8dee9
" Override the default Red & white
highlight ErrorMsg guibg=NONE guifg=#fa616a
highlight Tooltip guibg=NONE guifg=#88c0d0
highlight WarningMsg guibg=NONE guifg=#ffd394
