" Eddy Ekofo - Jan 2021
"
" TODO: Start migrating to LUA!!
" g Leader key: This has to be done early
let mapleader=" "
" let localleader=" "
nnoremap <Space> <Nop>

" LOAD: plugins
source $XDG_CONFIG_HOME/nvim/plugin/sets.vim
source $XDG_CONFIG_HOME/nvim/plugin/plugins-install.vim
source $XDG_CONFIG_HOME/nvim/plugin/keys.vim
source $XDG_CONFIG_HOME/nvim/plugin/which-key.vim
source $XDG_CONFIG_HOME/nvim/plugin/barbar.vim
source $XDG_CONFIG_HOME/nvim/plugin/floaterm.vim
source $XDG_CONFIG_HOME/nvim/plugin/dashboard.vim
" source $XDG_CONFIG_HOME/nvim/plugin/telescope.vim
source $XDG_CONFIG_HOME/nvim/plugin/vim-router.vim
source $XDG_CONFIG_HOME/nvim/plugin/theme.vim
source $XDG_CONFIG_HOME/nvim/plugin/gitgutter.vim

lua require('init')
" ROMOVE: netrw
" let g:loaded_netrw= 1
" let g:netrw_loaded_netrwPlugin= 1

" General: Cleanup ---------------------------- {{{
" commands that need to run at the end of my vimrc

" disable unsafe commands in your project-specific .vimrc files
" This will prevent :autocmd, shell and write commands from being
" run inside project-specific .vimrc files unless theyÕre owned by you.
set secure

" ShowCommand: turn off character printing to vim status line
set noshowcmd

" }}}

" TODO: see what this is doing, from the prime
"augroup numbertoggle :
"autocmd! : autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
": autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber :augroup END
