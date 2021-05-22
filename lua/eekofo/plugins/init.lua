-- Various plugins which I installed

-- Have Neoformat only msg when there is an error
vim.g.neoformat_only_msg_on_error = 1

-- Make Ranger to be hidden after picking a file
vim.g.rnvimr_enable_picker = 1

-- TODO: move this to it's own file
vim.g.indent_blankline_char = "▏"
vim.g.indent_blankline_show_first_indent_level = true
vim.g.indent_blankline_filetype_exclude = {
    "startify", "dashboard", "dotooagenda", "log", "fugitive", "gitcommit",
    "packer", "vimwiki", "markdown", "json", "txt", "vista", "help", "todoist",
    "peekaboo", "git", "TelescopePrompt", "undotree", "flutterToolsOutline", ""
}

vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
    "class", "function", "method", "block", "list_literal", "selector", "^if",
    "^table", "if_statement", "while", "for"
}
vim.cmd("autocmd CursorMoved * IndentBlanklineRefresh")

-- nvim-comment
require("nvim_comment").setup()
-- vim.api.nvim_set_keymap("n", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
-- BUG: not working since I moved the files aroung
-- see how to clean it up some how
vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>",
                        {noremap = true, silent = true})

-- Initialize plugins
require"colorizer".setup()
require"surround".setup {} -- TODO: fix this
require"todo-comments".setup {}
require("plugins.telescope")
require("plugins.dashboard")
require("plugins.web-devicons")
require("plugins.autopairs")
require("plugins.lualine")
require("plugins.barbar")
require("plugins.gitsigns")
require("plugins.nvimtree")
require("plugins.treesitter")
require("plugins.which-key")
require("plugins.dap")
