" Sets: - general conghigs
set nocompatible
set exrc                                " For custumised vim setting (will load vim files in project) No
set iskeyword+=-                        " treat dash separated words as a word text object"
set formatoptions-=cro                  " Stop newline continution of comments

set nowrap                              " Display long lines as just one line
set whichwrap+=<,>,[,],h,l
set encoding=utf-8     " The encoding displayed
set pumheight=10       " Makes popup menu smaller
set fileencoding=utf-8 " The encoding written to file
set ruler              " Show the cursor position all the time
set mouse+=a           " Enable your mouse
set splitbelow         " Horizontal splits will automatically be below
set splitright         " Vertical splits will automatically be to the right
set conceallevel=0     " So that I can see `` in markdown files
set cursorline         " Enable highlighting of the current line
set showtabline=2      " Always show tabs
set tabstop=4          " Insert 4 spaces for a tab
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set cindent        " C based indenting :h cindent to read more"
set inccommand=split                  " previow %s commands in a split window as I typeet expandtab
set autoread
set smartindent
set smartcase
" set ignorecase
set relativenumber
set number
set nohlsearch
set hidden                              " Keep all the buffers open in the background
set noerrorbells
set noswapfile
set nobackup
set timeoutlen=1000                      " By default timeoutlen is 1000 ms
set shiftround                          " For better indentation"
set clipboard=unnamedplus               " Copy paste between vim and everything else
set incsearch
set guifont=JetBrainsMono\ Nerd\ Font
set nowritebackup                       " This is recommended by coc
set undodir=~/.config/nvim/undodir  " Need a proper pluggin for it, all for keeping files saved
set undofile
set incsearch
set termguicolors
set scrolloff=10                         " start scholling when you're near the bottom by 8
set noshowmode                          " Get rid of --INSERT-- etc... don't need it
" set complete+=kspell                    " INFO: :take a look into this option"
set completeopt=menuone,noinsert,noselect,preview
set virtualedit=block
set signcolumn=yes                      " It sets the collum in the gutter for linting sake
syntax enable                           " Enabling syntax highlight

" Decent wildmenu
set wildmode=longest:full,full
set wildmenu
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" Gibe more space for displaying
set cmdheight=2

" Shorter update time for good user experience
set updatetime=50

" Don't pass messages to | ins-completion-menu | .
set shortmess+=c

                     " Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

set lazyredraw
set diffopt+=iwhite " No whitespace in vimdiff
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set synmaxcol=500
set backspace=2 " Backspace over newlines
set nofoldenable
set ttyfast
" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault
set path+=**
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set list
" settings for hidden chars
" what particular chars they are displayed with
:set lcs=tab:▒░,trail:▓
" or
:set listchars=tab:▒░,trail:▓,eol:↵,nbsp:␣,extends:…,precedes:…

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste
" Remove banner from netrw
" let g:netrw_banner = 0
" let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_winsize = 25
" let g:netrw_localrmdir='rm -r'

augroup AutoDeleteNetrwHiddenBuffers
  au!
  au FileType netrw setlocal bufhidden=wipe
augroup end

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500}
augroup END

function! MaxLineChars()
    let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endfunction

highlight HighlightedyankRegion cterm=reverse gui=reverse

augroup MAX_CHARS_COLUMN
    autocmd!
    autocmd FileType cpp,h,hpp,cxx,cs,fish,bash,ru,ts,java,php,lua,javascript :call MaxLineChars()
    autocmd BufLeave * :call clearmatches()
augroup END

" Remove whitespace
function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup THE_ED_CLEAN
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" You can't stop me
cmap w!! w !sudo tee %

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" imap <tab> <Plug>(completion_smart_tab)
" imap <s-tab> <Plug>(completion_smart_s_tab)

" CPP setup done using this tutorial https://xuechendi.github.io/2019/11/11/VIM-CPP-IDE-2019-111-11-VIM_CPP_IDE
" Code formatting
autocmd FileType c,cpp,h,hpp,proto,javascript AutoFormatBuffer clang-format