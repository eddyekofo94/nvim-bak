" Eddy Ekofo - Jan 2021

" Sets: to be extracted
set exrc                                " For custumised vim setting (will load vim files in project) No
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set smartcase
set ignorecase
set relativenumber
set number
set nohlsearch
set hidden                              " Keep all the buffers open in the background
set noerrorbells
set noswapfile
set nobackup
set undodir=$NVIM_PLUGIN_DIR/undodir    " Need a proper pluggin for it, all for keeping files saved
set undofile
set incsearch
set termguicolors
set scrolloff=8                         " start scholling when you're near the bottom by 8
set noshowmode
set completeopt=menuone,noinsert,noselect
set signcolumn=yes                      " It sets the collum in the gutter for linting sake

" Gibe more space for displaying
set cmdheight=2

" Shorter update time for good user experience
set updatetime=50

" Don't pass messages to | ins-completion-menu | .
set shortmess+=c
