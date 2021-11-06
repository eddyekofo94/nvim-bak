-- Initialise eveything from here

require('impatient')
require('packer_compiled')
vim.cmd("luafile ~/.config/nvim/lua/eekofo/globals/init.lua")
vim.cmd("luafile ~/.config/nvim/lua/eekofo/install-plugins.lua")
vim.cmd("luafile ~/.config/nvim/globals.lua")
vim.cmd("luafile ~/.config/nvim/base-settings.lua")
require("eekofo.globals")
require("eekofo")
