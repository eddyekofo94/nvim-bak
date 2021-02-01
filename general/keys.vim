" Keys:
" Which mappings for what
" Better indenting
vnoremap < <gv
vnoremap > >gv

" TAB in general mode will move to text buffer
nnoremap <silent> <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <silent> <S-TAB> :bprevious<CR>

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)
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
" Source my init.vim
nnoremap <Leader><CR> :so $MYVIMRC<CR>

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <C-c> <esc>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
" I don't really agree with this setup but I will keep it here if I ever
" find it decesarry one day
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Change the current word in insertmode.
"   Auto places you into the spot where you can start typing to change it.
nnoremap <c-r>w :%s/<c-r><c-w>//g<left><left>

nnoremap <M-CR> :let v:hlsearch=!v:hlsearch<CR>
nnoremap Y  y$ " Thank you TPope

nnoremap <silent> oo :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> OO :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>
