-- Initialise eveything from here
--require("globals")
vim.cmd("source ~/.config/nvim/vimscript/keys.vim")
vim.cmd("luafile ~/.config/nvim/globals.lua")
vim.cmd("luafile ~/.config/nvim/base-settings.lua")
require("eekofo")
require('plenary.reload').reload_module('eekofo', true)
