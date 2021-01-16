
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
Plug 'wbthomason/lsp-status.nvim'
" Have the file system follow you around
Plug 'airblade/vim-rooter'

" Theme
" Nord! the best colorscheme
Plug 'arcticicestudio/nord-vim'
Plug 'srcery-colors/srcery-vim'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'gruvbox-community/gruvbox'

Plug 'glepnir/galaxyline.nvim'
Plug 'kyazdani42/nvim-web-devicons'
" Better tabline
Plug 'romgrk/barbar.nvim'
" Better Comments
Plug 'tpope/vim-commentary'
Plug 'lukas-reineke/format.nvim'
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
" Dashboard
Plug 'glepnir/dashboard-nvim'
" Better Syntax Support
Plug 'sheerun/vim-polyglot'
" auto set indent settings
Plug 'tpope/vim-sleuth'
" Undo Tree: For better undoing
Plug 'mbbill/undotree'

" Snippets
Plug 'honza/vim-snippets'

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
