" Eddy Ekofo - Jan 2021

" TODO: Start migrating to LUA!!
" g Leader key: This has to be done early
let mapleader=" "
nnoremap <Space> <Nop>

augroup SET_SHELL
    au!
    autocmd VimEnter * set shell=/bin/bash
augroup end

augroup SOURCE_VIM_FILES
    au!
    autocmd BufWritePost vim :so $MYVIMRC
augroup end

augroup TerminalExit
    au!
    autocmd TermOpen * set shell=/usr/local/bin/fish
    autocmd TermOpen * startinsert
augroup end

" For exiting the termial mode. Better than the default config
tnoremap <Esc> <C-\><C-n><CR>

" LOAD: plugins
source $XDG_CONFIG_HOME/nvim/plugin/sets.vim
source $XDG_CONFIG_HOME/nvim/plugin/plugins-install.vim
source $XDG_CONFIG_HOME/nvim/plugin/keys.vim
source $XDG_CONFIG_HOME/nvim/plugin/which-key.vim
source $XDG_CONFIG_HOME/nvim/plugin/floaterm.vim
source $XDG_CONFIG_HOME/nvim/plugin/dashboard.vim
" source $XDG_CONFIG_HOME/nvim/plugin/telescope.vim
source $XDG_CONFIG_HOME/nvim/plugin/vim-router.vim
source $XDG_CONFIG_HOME/nvim/plugin/theme.vim
source $XDG_CONFIG_HOME/nvim/plugin/gitgutter.vim
source $XDG_CONFIG_HOME/nvim/after/plugin/tabular.vim
source $XDG_CONFIG_HOME/nvim/plugin/barbar.vim

lua require('init')
" inoremap <C-f> <C-x><C-f> TODO: see if this can be utilised somehow
" Not sure about this maybe if it gets
" too anoying you can change it again
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
" This fixes the tab completion: https://stackoverflow.com/a/16625862/5458010
let g:UltiSnipsExpandTrigger = '<F5>'
" possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_trigger_on_delete = 1
let g:completion_confirm_key = "<CR>"
let g:completion_sorting = "length"
let g:completion_matching_smart_case = 1
" let g:completion_trigger_keyword_length = 2 " default = 1
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
augroup CompletionTriggerCharacter
    autocmd!
    autocmd BufEnter * let g:completion_trigger_character = ['.']
    autocmd BufEnter *.c,*.cpp let g:completion_trigger_character = ['.', '::']
augroup end
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment" }

augroup lsp_status
    autocmd BufRead,BufNewFile autocmd CursorHold,BufEnter <buffer> lua require'lsp-status'.update_current_function()
augroup end

" General: Cleanup ---------------------------- {{{
" commands that need to run at the end of my vimrc

" disable unsafe commands in your project-specific .vimrc files
" This will prevent :autocmd, shell and write commands from being
" run inside project-specific .vimrc files unless theyÕre owned by you.
set secure
" }}}

