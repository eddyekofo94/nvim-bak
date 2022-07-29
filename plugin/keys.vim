" Keys:
" Which mappings for what
" Better indenting
vnoremap < <gv
vnoremap > >gv

" TODO: if it works in lua, REMOVE!"
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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

" nnoremap <leader>= <cmd><C-w> <C-=>

" HARD MODE - Disabled arrows
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Very magic by default, got this from thePrimragen (Don't know exactly what it
" does
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <C-c> <esc>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
" I don't really agree with this setup but I will keep it here if I ever
" find it decesarry one day
" inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Change the current word in insertmode.
"   Auto places you into the spot where you can start typing to change it.
nnoremap <c-r>w :%s/<c-r><c-w>//g<left><left>

nnoremap <M-CR> :let v:hlsearch=!v:hlsearch<CR>

" highlight HighlightedyankRegion cterm=reverse gui=reverse
