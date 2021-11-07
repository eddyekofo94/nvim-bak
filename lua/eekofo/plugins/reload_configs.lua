local reload = require("nvim-reload")
-- If you use Neovim's built-in plugin system
-- Or a plugin manager that uses it (eg: packer.nvim)
local plugin_dirs = vim.fn.stdpath("data") .. "/site/pack/*/opt/*"
-- ~/.local/share/nvim/site/pack/packer/opt/gruvbox-flat.nvim

reload.vim_reload_dirs = {
	vim.fn.stdpath("config"),
	plugin_dirs,
}

reload.modules_reload_external = { "packer" }
