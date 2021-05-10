-- Initialize plugins
require("plugins.telescope")
require("plugins.web-devicons")
require("plugins.autopairs")
require("plugins.galaxyline")
require("plugins.barbar")
require("plugins.gitsigns")
require("plugins.nvimtree")
require("plugins.dashboard")
require("plugins.treesitter")

-- nvim-comment
require("nvim_comment").setup()
vim.api.nvim_set_keymap("n", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})

require "colorizer".setup()
require "surround".setup {} -- TODO: fix this

-- Terminal
require "toggleterm".setup {
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    start_in_insert = true,
    shell = vim.o.shell, -- change the default shell
    direction = {"vertical"}
}
