" Keys:
" Which mappings for what
" Better indenting
vnoremap < <gv
vnoremap > >gv

" TAB in general mode will move to text buffer
nnoremap <silent> <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <silent> <S-TAB> :bprevious<CR>

" Move selected line / block of text in visual mode
" shift + k to move up
" shift + j to move down
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" HARD MODE - Disabled arrows
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Resise window with arrow keys
nnoremap <silent> <Up>  :resize +2<CR>
nnoremap <silent> <Down>    :resize -2<CR>
nnoremap <silent> <Left>  :vertical resize -2<CR>
nnoremap <silent> <Right> :vertical resize +2<CR>

" Very magic by default, got this from theRimragen (Don't knoq exactly what it
" does
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" Limelight key mappings
nmap <Leader>l <Plug>(Limelight)
xmap <Leader>l <Plug>(Limelight)

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"autocmd! User GoyoEnter Limelight
"autocmd! User GoyoLeave Limelight!

" TODO: Fix the limelight not closing on GoyoLeave!!
augroup ZenMode
  au!
  autocmd User GoyoEnter Limelight
  autocmd User GoyoEnter lua require('galaxyline').disable_galaxyline()
augroup END
" autocmd! User GoyoEnter Limelight lua require('galaxyline').disable_galaxyline()
augroup ZenModeOff
  au!
  autocmd! User GotoLeave Limelight!
  autocmd User GoyoLeave lua require('galaxyline').galaxyline_augroup()
augroup END
" autocmd! User GoyoLeave Limelight! lua require('galaxyline').galaxyline_augroup()
