-- Initialize plugins
require("plugins.telescope")
require("plugins.web-devicons")
require("plugins.autopairs")
require("plugins.galaxyline")
require("plugins.barbar")
require("plugins.gitsigns")
require("plugins.nvimtree")

-- nvim-comment
require("nvim_comment").setup()
vim.api.nvim_set_keymap("n", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
