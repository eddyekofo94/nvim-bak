-- Various plugins which I installed
-- Terminal
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

-- TODO: move this to it's own file
vim.g.indent_blankline_char = "▏"
vim.g.indent_blankline_show_first_indent_level = true
vim.g.indent_blankline_filetype_exclude = {
    "startify",
    "dashboard",
    "dotooagenda",
    "log",
    "fugitive",
    "gitcommit",
    "packer",
    "vimwiki",
    "markdown",
    "json",
    "txt",
    "vista",
    "help",
    "todoist",
    -- "NvimTree",
    "peekaboo",
    "git",
    "TelescopePrompt",
    "undotree",
    "flutterToolsOutline",
    ""
}

vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
    "class",
    "function",
    "method",
    "block",
    "list_literal",
    "selector",
    "^if",
    "^table",
    "if_statement",
    "while",
    "for"
}
vim.cmd("autocmd CursorMoved * IndentBlanklineRefresh")


-- nvim-comment
require("nvim_comment").setup()
vim.api.nvim_set_keymap("n", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})

-- Initialize plugins
require "colorizer".setup()
require "surround".setup {} -- TODO: fix this
require "todo-comments".setup {}
require("plugins.telescope")
-- require("plugins.dashboard")
require("plugins.web-devicons")
require("plugins.autopairs")
require("plugins.galaxyline")
require("plugins.barbar")
require("plugins.gitsigns")
require("plugins.nvimtree")
-- require("plugins.treesitter")
require("plugins.which-key")
