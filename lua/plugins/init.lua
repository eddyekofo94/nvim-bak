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
    require"todo-comments".setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
-- Terminal
require "toggleterm".setup {
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    start_in_insert = true,
    shell = vim.o.shell, -- change the default shell
    direction = {"vertical"}
}

vim.g.floaterm_keymap_toggle = "<F5>" -- TODO: fix
vim.g.floaterm_keymap_next = "<F2>"
vim.g.floaterm_keymap_prev = "<F3>"
vim.g.floaterm_keymap_new = "<F4>"
vim.g.floaterm_keymap_kill = "<F12>"
vim.g.floaterm_title = ""
vim.g.floaterm_gitcommit = "floaterm"
vim.g.floaterm_shell = "fish"
vim.g.floaterm_autoinsert = 1
vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8
vim.g.floaterm_wintitle = 0
vim.g.floaterm_autoclose = 1

-- Have Neoformat only msg when there is an error
vim.g.neoformat_only_msg_on_error = 1

 -- Make Ranger to be hidden after picking a file
vim.g.rnvimr_enable_picker = 1
