"
"
" EDDY: Key maps - helps with finding out your mapings
"
"

" Leader Key Maps

let @s = 'veS"'

" Timeout
let g:which_key_timeout = 100

let g:which_key_display_names = {'<CR>': '↵', '<TAB>': '⇆'}

" Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'
" set timeoutlen=100

" Coc Search & refactor
nnoremap <leader>? CocSearch <C-R>.expand("<cword>")<CR><CR>
let g:which_key_map['?'] = 'search word'

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0
let g:which_key_max_size = 0

" let g:which_key_position = 'botright'
" let g:which_key_position = 'topleft'
" let g:which_key_vertical = 1

" Change the colors if you want

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler


" Single mappings
let g:which_key_map['/'] = [ '<Plug>KommentaryLine'      , 'comment' ]
let g:which_key_map['.'] = [ ':e $MYVIMRC'           , 'open init' ]
let g:which_key_map['='] = [ '<C-W>='                , 'balance windows' ]
let g:which_key_map['d'] = [ ':bd!'                  , 'buffer delete' ]
let g:which_key_map['h'] = [ '<C-W>s'                , 'split below']
let g:which_key_map['n'] = [ ':let @/ = ""'          , 'no highlight' ]
let g:which_key_map['m'] = [ ':MaximizerToggle!'     , 'max window' ]
let g:which_key_map['t'] = [ ':term'                 , 'terminal' ]
let g:which_key_map['p'] = [ ':Telescope find_files' , 'search files' ]
let g:which_key_map['u'] = [ ':UndotreeToggle'       , 'undo tree']
let g:which_key_map['v'] = [ '<C-W>v'                , 'split vertical']
let g:which_key_map['z'] = [ 'Goyo'                  , 'zen' ]

" Group mappings

" a is for actions
let g:which_key_map.a = {
      \ 'name' : '+actions' ,
      \ 'c' : [':ColorizerToggle'        , 'colorizer'],
      \ 'h' : [':let @/ = ""'            , 'remove search highlight'],
      \ 's' : [':s/\%V\(.*\)\%V/"\1"/'   , 'surround'],
      \ 't' : [':FloatermToggle'         , 'float term'],
      \ 'w' : [':StripWhitespace'        , 'strip whitespace'],
      \ }

let g:which_key_map.f = {
      \'name' : '+find',
      \ 'g' : [':Telescope live_grep'      , 'live grep' ]
      \}

" Register which key map
call which_key#register('<Space>', "g:which_key_map")