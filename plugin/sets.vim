" Sets: - general configs
set nocompatible
set exrc                                " For custumised vim setting (will load vim files in project) No
set iskeyword+=-                      	" treat dash separated words as a word text object"
set formatoptions-=cro                  " Stop newline continution of comments

set nowrap                              " Display long lines as just one line
set whichwrap+=<,>,[,],h,l
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			            " Show the cursor position all the time
set mouse+=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set conceallevel=0                      " So that I can see `` in markdown files
set cursorline                          " Enable highlighting of the current line
set showtabline=2                       " Always show tabs
set tabstop=4                           " Insert 4 spaces for a tab
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
"set smartcase
"set ignorecase
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
set undodir=$NVIM_PERSONAL_DIR/undodir                   " Need a proper pluggin for it, all for keeping files saved
set undofile
set incsearch
set termguicolors
set scrolloff=8                         " start scholling when you're near the bottom by 8
set noshowmode                          " Get rid of --INSERT-- etc... don't need it
set completeopt=menuone,noinsert,noselect
set signcolumn=yes                      " It sets the collum in the gutter for linting sake
syntax enable                           " Enabling syntax highlight

" Gibe more space for displaying
set cmdheight=2

" Shorter update time for good user experience
set updatetime=50

" Don't pass messages to | ins-completion-menu | .
set shortmess+=c

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

function! MaxLineChars()
    let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endfunction

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
