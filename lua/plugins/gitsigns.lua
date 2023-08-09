return {
    -- git signs
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local signs = require("gitsigns")
        signs.setup {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, { expr = true })

                map('n', '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, { expr = true })
            end,
            signs = {
                add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr" },
                change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr" },
                delete = { hl = "GitSignsDelete", text = "│ ", numhl = "GitSignsDeleteNr" },
                topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr" },
                changedelete = { hl = "GitSignsDelete", text = "│", numhl = "GitSignsChangeNr" },
            },

            -- Highlights just the number part of the number column
            numhl = true,

            -- Highlights the _whole_ line.
            --    Instead, use gitsigns.toggle_linehl()
            linehl = false,

            -- Highlights just the part of the line that has changed
            --    Instead, use gitsigns.toggle_word_diff()
            word_diff = false,

            current_line_blame_opts = {
                delay = 2000,
                virt_text_pos = "eol",
            },
            watch_gitdir = {
                interval = 1000,
                follow_files = true,
            },
            preview_config = {
                border = "single",
                style = "minimal",
            },
            sign_priority = 6,
            update_debounce = 200,
            status_formatter = nil, -- Use default
        }
    end,
}
