return {
    {
        "folke/zen-mode.nvim",
        event        = "VeryLazy",
        dependencies = {
            {
                "folke/twilight.nvim",
                config = function()
                    require("twilight").setup {
                        context = -1,
                        treesitter = true,
                    }
                end,
            },
        },
        config       = function()
            require("zen-mode").setup {
                plugins = {
                    wezterm = {
                        enabled = true,
                        -- can be either an absolute font size or the number of incremental steps
                        font = "+10", -- (10% increase per step)
                    },
                },
                window = {
                    backdrop = 1,
                    height = 0.9,
                    -- width = 140,
                    options = {
                        concealcursor = 'n',
                        conceallevel = 3,
                        cursorcolumn = false,
                        cursorline = false,
                        foldcolumn = '0',
                        list = false,
                        number = false,
                        relativenumber = false,
                        signcolumn = 'no',
                        statusline = ' ',
                    },
                },
                on_open = function()
                    -- require("noice").disable()
                end,
                -- callback where you can add custom code when the Zen window closes
                on_close = function()
                    -- require("noice").enable()
                end,
            }

            require("twilight").setup {
                context = -1,
                treesitter = true,
            }
        end,
    },
}
