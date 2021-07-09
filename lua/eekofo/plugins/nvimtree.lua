vim.g.nvim_tree_disable_netrw = 0 -- "1 by default, disables netrw
-- vim.g.nvim_tree_hijack_netrw = 0 --"1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
vim.g.nvim_tree_hide_dotfiles = 1 -- 0 by default, this option hides files and folders starting with a dot `.`
vim.g.nvim_tree_indent_markers = 1 -- "0 by default, this option shows indent markers when folders are open
vim.g.nvim_tree_follow = 1 -- "0 by default, this option allows the cursor to be updated when entering a buffer
vim.g.nvim_tree_auto_close = O.auto_close_tree -- 0 by default, closes the tree when it's the last window
vim.g.nvim_tree_auto_ignore_ft = { "dashboard", "startify" } --empty by default, don't auto open tree on specific filetypes.
local tree_cb = require("nvim-tree.config").nvim_tree_callback

vim.g.nvim_tree_bindings = {
    -- default mappings
    { key = { "<CR>", "o", "l" }, cb = tree_cb("edit") },
    { key = "h", cb = tree_cb("close_node") },
    { key = "R", cb = tree_cb("refresh") },
    { key = "a", cb = tree_cb("create") },
    { key = "d", cb = tree_cb("remove") },
    { key = "r", cb = tree_cb("rename") },
    { key = "<C-r>", cb = tree_cb("full_rename") },
    { key = "x", cb = tree_cb("cut") },
    { key = "c", cb = tree_cb("copy") },
    { key = "p", cb = tree_cb("paste") },
}

vim.g.nvim_tree_show_icons = { git = 1, folders = 1, files = 1 }
vim.g.nvim_tree_icons = {
    default = "",
    symlink = "",
    -- git = {
    --     unstaged = "?",
    --     staged = "?",
    --     unmerged = "?",
    --     renamed = "?",
    --     untracked = "?",
    --     deleted = "?",
    --     ignored = "?",
    -- },
    folder = {
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
    },
}
