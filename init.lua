-- Initialise eveything from here
require("globals")
vim.cmd("source ~/.config/nvim/vimscript/keys.vim")
require("install-plugins")
require("colorscheme")
require("settings")
vim.cmd("luafile ~/.config/nvim/base-settings.lua")
require("utils")
require("autocommands")
require("keymappings")
require("lsp")
require("plugins")

-- Which Key (Hope to replace with Lua plugin someday) INFO: currently removing
-- this
--vim.cmd("source ~/.config/nvim/vimscript/whichkey/init.vim")
