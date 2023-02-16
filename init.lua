-- Initialise eveything from here

-- require("impatient")
-- require("packer_compiled")
-- vim.cmd("luafile ~/.config/nvim/lua/eekofo/install-plugins.lua")
-- vim.cmd("luafile ~/.config/nvim/lua/eekofo/globals/init.lua")
-- vim.cmd("luafile ~/.config/nvim/globals.lua")
-- vim.cmd("luafile ~/.config/nvim/base-settings.lua")
-- require("eekofo.globals")
-- require("eekofo")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup("plugins") -- INFO: this should be on the LAST LINE
