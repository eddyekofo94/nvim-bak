" Eddy Ekofo - Jan 2021

" TODO: Start migrating to LUA!!
" g Leader key: This has to be done early
let mapleader=" "
nnoremap <Space> <Nop>

augroup SET_SHELL
    au!
    autocmd VimEnter * set shell=/bin/bash
augroup end

" LOAD: plugins
source $XDG_CONFIG_HOME/nvim/general/terminal.vim
source $XDG_CONFIG_HOME/nvim/general/sets.vim
source $XDG_CONFIG_HOME/nvim/general/plugins-install.vim
source $XDG_CONFIG_HOME/nvim/general/keys.vim
source $XDG_CONFIG_HOME/nvim/general/theme.vim
source $XDG_CONFIG_HOME/nvim/general/terminal.vim
source $XDG_CONFIG_HOME/nvim/after/ftplugin/which-key.vim
source $XDG_CONFIG_HOME/nvim/after/ftplugin/floaterm.vim
source $XDG_CONFIG_HOME/nvim/after/ftplugin/dashboard.vim
source $XDG_CONFIG_HOME/nvim/after/ftplugin/vim-router.vim
source $XDG_CONFIG_HOME/nvim/after/ftplugin/gitgutter.vim
source $XDG_CONFIG_HOME/nvim/after/ftplugin/tabular.vim
source $XDG_CONFIG_HOME/nvim/after/ftplugin/nvim-tree.vim
source $XDG_CONFIG_HOME/nvim/after/ftplugin/barbar.vim
lua require('init')

let g:UltiSnipsExpandTrigger = '<F5>'
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')

" General: Cleanup ---------------------------- {{{
" commands that need to run at the end of my vimrc

" disable unsafe commands in your project-specific .vimrc files
" This will prevent :autocmd, shell and write commands from being
" run inside project-specific .vimrc files unless theyÕre owned by you.
set secure
" }}}

