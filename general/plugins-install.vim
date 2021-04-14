
" TODO: Convert to Lua, user packer add: https://github.com/wbthomason/packer.nvim
" Follow TJ's example on how to install the plugin manager if it doesn't exist

call plug#begin("$XDG_CONFIG_HOME/nvim/plugged")
Plug 'junegunn/limelight.vim'
Plug 'godlygeek/tabular'                 " Line it up
" -- Configurations for neovim lsp.
" --   neovim/neovim has all of the LSP code.
Plug 'neovim/nvim-lspconfig'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'
Plug 'glepnir/lspsaga.nvim'
Plug 'onsails/lspkind-nvim'
" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
" Lua development
Plug 'tjdevries/nlua.nvim'

" This replaces tpope's vim-commentary
Plug 'b3nj5m1n/kommentary'
" (OPTIONAL): This is a suggested plugin to get better Lua syntax highlighting
"   but it's not currently required
Plug 'euclidianAce/BetterLua.vim'

" For rust developemnt
Plug 'rust-lang/rust.vim' " Not sure I need this
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
Plug 'tpope/vim-surround'
" Trying this formatter instead
Plug 'sbdchd/neoformat'
" Telescope for fuzzy searching
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Highlight when copied
Plug 'machakann/vim-highlightedyank'

" See what keys do like in emacs
Plug 'liuchengxu/vim-which-key'
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
" Undo Tree: For better undoing
Plug 'mbbill/undotree'

" Snippets
Plug 'norcalli/ui.nvim'
Plug 'dag/vim-fish'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" For window toggling
Plug 'szw/vim-maximizer'
" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
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
