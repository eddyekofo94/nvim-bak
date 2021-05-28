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

vim.g.indent_start_level = 1

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

-- Initialize plugins
require"colorizer".setup()
require"surround".setup {}
require"todo-comments".setup {}
require("eekofo.plugins.telescope")
require("eekofo.plugins.dashboard")
require("eekofo.plugins.web-devicons")
require("eekofo.plugins.autopairs")
require("eekofo.plugins.lualine")
require("eekofo.plugins.barbar")
require("eekofo.plugins.gitsigns")
require("eekofo.plugins.nvimtree")
require("eekofo.plugins.treesitter")
require("eekofo.plugins.which-key")
require("eekofo.plugins.dap")
require("eekofo.plugins.fterm")
