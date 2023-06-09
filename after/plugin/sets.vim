" Sets: - general configs
" TODO: slowly move to lua if possible

set nocompatible
set exrc                                " For custumised vim setting (will load vim files in project) No
set iskeyword+=-                        " treat dash separated words as a word text object"
set formatoptions-=cro                  " Stop newline continution of comments

set nowrap                              " Display long lines as just one line
set whichwrap+=<,>,[,],h,l " Not sure what this does
set encoding=utf-8     " The encoding displayed
set pumheight=10       " Makes popup menu smaller
set fileencoding=utf-8 " The encoding written to file
set ruler              " Show the cursor position all the time
set mouse+=a           " Enable your mouse

set splitbelow         " Horizontal splits will automatically be below
set splitright         " Vertical splits will automatically be to the right

set conceallevel=0     " So that I can see `` in markdown files
set cursorline         " Enable highlighting of the current line
set cursorcolumn       " Enable column highlight
set showtabline=2      " Always show tabs
set tabstop=4          " Insert 4 spaces for a tab
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
" set cindent        " C based indenting :h cindent to read more"
set inccommand=split                  " previow %s commands in a split window as I typeet expandtab
set autoread    " When a file has been detected to have been changed load it
set smartindent

set relativenumber
set number

set hlsearch
set ignorecase " All your searches will be case insensitive
set smartcase  " Your search will be case sensitive if it contains an uppercase letter
set hidden     " Keep all the buffers open in the background
set noerrorbells
set noswapfile " Helpful for undotree pluggin
set nobackup
set timeoutlen=1000                      " By default timeoutlen is 1000 ms
set shiftround                          " For better indentation"
set clipboard=unnamedplus               " Copy paste between vim and everything else
set nowritebackup                       " This is recommended by coc
set undodir=~/.config/nvim/undodir  " Need a proper pluggin for it, all for keeping files saved
set undofile
set scrolloff=7
set sidescrolloff=6
set noshowmode                          " Get rid of --INSERT-- etc... don't need it
set complete+=kspell                    " INFO: :take a look into this option
set pumblend=17 ""Enables pseudo-transparency for the popup-menu
set virtualedit=block
set signcolumn=yes                      " It sets the collumn in the gutter for linting sake
syntax enable                           " Enabling syntax highlight
setglobal fileformats=unix,dos,mac
" Load an indent file for the detected file type.
filetype indent on

augroup CHAR_BREAK
  au!
  autocmd FileType vim set textwidth=120
augroup end

" Decent wildmenu
set wildmode=longest:full,full
set wildmenu
set wildoptions=pum

" Shorter update time for good user experience
set updatetime=300

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines INFO: not sure about this
" set lazyredraw -- this breaks Noice
set diffopt+=iwhite " No whitespace in vimdiff
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set synmaxcol=500
" set backspace=indent,eol,start " Backspace over newlines

set nofoldenable
set ttyfast

" Proper search
set incsearch
set gdefault
set path+=**
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set list

" settings for hidden chars
" what particular chars they are displayed with
set listchars=tab:→\ ,nbsp:␣,trail:•,eol:↵,precedes:«,extends:»

" Enable blinking together with different cursor shapes for insert/command mode, and cursor highlighting:
set guicursor+=i:block-Cursor
set guicursor+=n-v-c:blinkon10
set guicursor+=a:blinkon20

set foldmethod=expr
set foldlevelstart=99
set foldexpr=nvim_treesitter#foldexpr()

" Leave paste mode when leaving insert mode INFO: I don't get this fully
autocmd InsertLeave * set nopaste

function! MaxLineChars()
    let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endfunction

augroup MAX_CHARS_COLUMN
    autocmd!
    autocmd FileType,BufWinEnter cpp,h,hpp,cxx,cs,fish,shell,bash,go,rust,typescript,java,php,lua,javascript :call MaxLineChars()
    autocmd BufLeave,BufDelete * :call clearmatches()
augroup end


" Jump to last edit position on opening file
" if has("autocmd")
"   " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
"   au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" endif

" Improve the search
" nnoremap ? ?\v
" nnoremap / /\v
" cnoremap %s/ %sm/

" You can't stop me
cmap w!! w !sudo tee %

autocmd FileType * setlocal nolinebreak

augroup Terminal
    au!
    autocmd TermOpen  * startinsert
    autocmd FileType term set nonumber
augroup END

highlight HighlightedyankRegion cterm=reverse gui=reverse

" Display cursorline and cursorcolumn ONLY in active window.
" augroup cursor_off
"     autocmd!
"     autocmd WinLeave * set nocursorline nocursorcolumn
"     autocmd WinEnter * set cursorline cursorcolumn
" augroup END

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <up> <c-w>+
noremap <down> <c-w>-
noremap <left> <c-w>>
noremap <right> <c-w><

" Center the cursor vertically when moving to the next word during a search.
" nnoremap n nzz
" nnoremap N Nzz

" TODO: Fix this some day
" disable syntax highlighting in big files
" function DisableSyntaxTreesitter()
"     echo("Big file, disabling syntax, treesitter and folding")
"     if exists(':TSBufDisable')
"         exec 'TSBufDisable autotag'
"         exec 'TSBufDisable highlight'
"         " etc...
"     endif
"
"     set foldmethod=manual
"     syntax clear
"     syntax off    " hmmm, which one to use?
"     filetype off
"     set noundofile
"     set noswapfile
"     set noloadplugins
" endfunction
"
" augroup BigFileDisable
"     autocmd!
"     " autocmd BufWinEnter * if getfsize(expand("%")) > 512 * 1024 | exec DisableSyntaxTreesitter() | endif
"     autocmd BufReadPre,FileReadPre * if getfsize(expand("%")) > 512 * 1024 | exec DisableSyntaxTreesitter() | endif
"
" augroup END
