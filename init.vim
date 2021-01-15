" Eddy Ekofo - Jan 2021

" g Leader key
let mapleader=" "
" let localleader=" "
nnoremap <Space> <Nop>

" LOAD: plugins
source $XDG_CONFIG_HOME/nvim/plugin/sets.vim
" TODO: Convert to Lua, user packer add: https://github.com/wbthomason/packer.nvim
" Follow TJ's example on how to install the plugin manager if it doesn't exist
call plug#begin("$XDG_CONFIG_HOME/nvim/plugged")
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/limelight.vim'
" Have the file system follow you around
Plug 'airblade/vim-rooter'
" Better Comments
Plug 'tpope/vim-commentary'
" Telescope for fuzzy searching
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Highlight when copied
Plug 'machakann/vim-highlightedyank'

" See what keys do like in emacs
Plug 'liuchengxu/vim-which-key'
" Vista
Plug 'liuchengxu/vista.vim'
" Terminal
Plug 'voldikss/vim-floaterm'
" Auto pairs for '(' '[' '{'
Plug 'jiangmiao/auto-pairs'
" Closetags
Plug 'alvan/vim-closetag'
" Ranger file viewer
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
" Better Syntax Support
Plug 'sheerun/vim-polyglot'
" auto set indent settings
Plug 'tpope/vim-sleuth'
" Undo Tree: For better undoing
Plug 'mbbill/undotree'

    " Snippets
    Plug 'honza/vim-snippets'
" Theme
" Nord! the best colorscheme
Plug 'arcticicestudio/nord-vim'
Plug 'glepnir/galaxyline.nvim'
Plug 'kyazdani42/nvim-web-devicons'

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
source $XDG_CONFIG_HOME/nvim/plugin/keys.vim
source $XDG_CONFIG_HOME/nvim/plugin/which-key.vim
source $XDG_CONFIG_HOME/nvim/plugin/rnvimr.vim
source $XDG_CONFIG_HOME/nvim/plugin/telescope.vim
source $XDG_CONFIG_HOME/nvim/plugin/theme.vim
source $XDG_CONFIG_HOME/nvim/plugin/floaterm.vim

" General: Cleanup ---------------------------- {{{
" commands that need to run at the end of my vimrc

" disable unsafe commands in your project-specific .vimrc files
" This will prevent :autocmd, shell and write commands from being
" run inside project-specific .vimrc files unless theyÕre owned by you.
set secure

" ShowCommand: turn off character printing to vim status line
set noshowcmd

" }}}
