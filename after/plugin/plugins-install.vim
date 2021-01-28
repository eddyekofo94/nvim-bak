
" TODO: Convert to Lua, user packer add: https://github.com/wbthomason/packer.nvim
" Follow TJ's example on how to install the plugin manager if it doesn't exist

call plug#begin("$XDG_CONFIG_HOME/nvim/plugged")
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/limelight.vim'
Plug 'godlygeek/tabular'                 " Line it up
Plug 'pechorin/any-jump.vim'
Plug 'rhysd/git-messenger.vim'            " Floatinf git, looks like VSCode, it is delicious
" -- Configurations for neovim lsp.
" --   neovim/neovim has all of the LSP code.
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'wbthomason/lsp-status.nvim'       " TODO: make sure this works
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'
" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
" Lua development
Plug 'tjdevries/nlua.nvim'
" (OPTIONAL): This is a suggested plugin to get better Lua syntax highlighting
"   but it's not currently required
Plug 'euclidianAce/BetterLua.vim'

" For rust developemnt
Plug 'rust-lang/rust.vim' " Not sure I need this
Plug 'octol/vim-cpp-enhanced-highlight'
" (OPTIONAL): If you wish to have fancy lua folds, you can check this out.
Plug 'tjdevries/manillua.nvim'
" Have the file system follow you around
Plug 'airblade/vim-rooter'

" Theme
" Nord! the best colorscheme
Plug 'arcticicestudio/nord-vim'
Plug 'srcery-colors/srcery-vim'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'gruvbox-community/gruvbox'
" Used for the status-line
Plug 'glepnir/galaxyline.nvim'
Plug 'kyazdani42/nvim-web-devicons'
" Better tabline
Plug 'romgrk/barbar.nvim'
" Better Comments
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
" Trying this formatter instead
Plug 'sbdchd/neoformat'
" Plug 'Yggdroot/indentLine'
Plug 'nathanaelkane/vim-indent-guides'
" Telescope for fuzzy searching
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Highlight when copied
Plug 'machakann/vim-highlightedyank'

" See what keys do like in emacs
Plug 'liuchengxu/vim-which-key'
" TODO fix this, make it work
" Vista
Plug 'liuchengxu/vista.vim'
" Terminal
Plug 'voldikss/vim-floaterm'
" Auto pairs for '(' '[' '{'
Plug 'jiangmiao/auto-pairs'
" File explorer
Plug 'kyazdani42/nvim-tree.lua'
" Dashboard
Plug 'glepnir/dashboard-nvim'
" Better Syntax Support
Plug 'sheerun/vim-polyglot'
" auto set indent settings
Plug 'tpope/vim-sleuth'
" Undo Tree: For better undoing
Plug 'mbbill/undotree'

" Snippets
Plug  'norcalli/ui.nvim'
Plug 'dag/vim-fish'
Plug 'SirVer/ultisnips'

" For window toggling
Plug 'szw/vim-maximizer'
" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'rhysd/git-messenger.vim'

" Zen mode
Plug 'junegunn/goyo.vim'
" Smooth scroll
Plug 'psliwka/vim-smoothie'
" Colorizer
Plug 'norcalli/nvim-colorizer.lua'
call plug#end()
" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
