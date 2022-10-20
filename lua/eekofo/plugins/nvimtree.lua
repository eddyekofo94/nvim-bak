-- a list of groups can be found at `:help nvim_tree_highlight`
local tree_cb = require("nvim-tree.config").nvim_tree_callback

local renderer = {
    root_folder_modifier = ":~",
    indent_markers = {
        enable = true,
        icons = {
            corner = "└ ",
            edge = "│ ",
            none = "  ",
        },
    },
    icons = {
        show = {
            folder = true,
            file = true,
            folder_arrow = true,
        },
        webdev_colors = true,
        git_placement = "before",
    },
    highlight_opened_files = "icon",
}

local list = {
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

-- following options are the default
require("nvim-tree").setup({
    -- INFO: see if this doesn't slow down the machine
    auto_reload_on_write = true,
    -- disables netrw completely
    disable_netrw = true,
    -- hijack netrw window on startup
    hijack_netrw = true,
    -- open the tree when running this setup function
    open_on_setup = false,
    -- will not open on setup if the filetype is in this list
    ignore_ft_on_setup = {},
    -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
    open_on_tab = false,
    sort_by = "name",
    -- hijacks new directory buffers when they are opened.
    diagnostics = {
        enable = true,
    },
    -- update_to_buf_dir = {
    --     -- enable the feature
    --     enable = true,
    --     -- allow to open the tree if it was previously closed
    --     auto_open = true,
    -- },
    filters = {
        dotfiles = false,
        custom = { ".git" },
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 400,
    },
    actions = {
        use_system_clipboard = true,
        change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
        },
        open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = {
                enable = true,
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                    filetype = { "dashboard", "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                    buftype = { "nofile", "terminal", "help" },
                },
            },
        },
    },
    respect_buf_cwd = true,
    -- hijack the cursor in the tree to put it at the start of the filename
    hijack_cursor = true,
    -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
    update_cwd = false,
    -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
    update_focused_file = {
        -- enables the feature
        enable = true,
        -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
        -- only relevant when `update_focused_file.enable` is true
        update_cwd = false,
        -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
        -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
        ignore_list = {},
    },
    -- configuration options for the system open command (`s` in the tree by default)
    system_open = {
        -- the command to run this, leaving nil should work in most cases
        cmd = nil,
        -- the command arguments as a list
        args = {},
    },
    renderer = renderer,
    view = {
        -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
        width = 30,
        -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
        side = "left",
        mappings = {
            -- custom only false will merge the list with the default mappings
            -- if true, it will only use your list to set the mappings
            custom_only = false,
            -- list of mappings to set on the tree manually
            list = list,
        },
    },
})
