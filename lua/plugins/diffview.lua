return {
    "sindrets/diffview.nvim",
    config = function()
        -- Lua
        local cb = require("diffview.config").diffview_callback

        require("diffview").setup({
            diff_binaries = false, -- Show diffs for binaries
            key_bindings = {
                disable_defaults = false, -- Disable the default key bindings
                -- The `view` bindings are active in the diff buffers, only when the current
                -- tabpage is a Diffview.
                view = {
                    ["<tab>"] = cb("select_next_entry"), -- Open the diff for the next file
                    ["<s-tab>"] = cb("select_prev_entry"), -- Open the diff for the previous file
                    ["<leader>e"] = cb("focus_files"), -- Bring focus to the files panel
                    ["<leader>b"] = cb("toggle_files"), -- Toggle the files panel.
                },
            },
        })
    end,
}
