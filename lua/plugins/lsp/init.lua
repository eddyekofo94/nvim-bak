return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            inlay_hints = { enabled = true },
        },
        dependencies = {
            { "neovim/nvim-lspconfig" },             -- Required
            { "williamboman/mason.nvim" },           -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional
            {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                config = function()
                    require("mason-tool-installer").setup {
                        auto_update = true,
                        debounce_hours = 24,
                        ensure_installed = {
                            "black",
                            "isort",
                        },
                    }
                end,
            },
            -- NOTE: not working as expected
            { "folke/neodev.nvim", config = true, opts = { experimental = { pathStrict = true } } },
            "simrat39/rust-tools.nvim",
            "scalameta/nvim-metals", -- Java
            {
                "williamboman/mason.nvim",
                config = function()
                    require("mason").setup()
                end,
            },
            "williamboman/mason-lspconfig.nvim",
            {
                "folke/lsp-trouble.nvim",
                config = function()
                    -- mapped to <space>lt -- this shows a list of diagnostics
                    require("trouble").setup({
                        height = 12, -- height of the trouble list
                        mode = "document_diagnostics",
                        action_keys = {
                            -- key mappings for actions in the trouble list
                            close = "q",                  -- close the list
                            cancel = "<esc>",             -- cancel the preview and get back to your last window / buffer / cursor
                            refresh = "r",                -- manually refresh
                            jump = { "<cr>", "<tab>" },   -- jump to the diagnostic or open / close folds
                            jump_close = { "o" },         -- jump to the diagnostic and close the list
                            toggle_mode = "m",            -- toggle between "workspace" and "document" diagnostics mode
                            toggle_preview = "P",         -- toggle auto_preview
                            hover = "K",                  -- opens a small poup with the full multiline message
                            preview = "p",                -- preview the diagnostic location
                            close_folds = { "zM", "zm" }, -- close all folds
                            open_folds = { "zR", "zr" },  -- open all folds
                            toggle_fold = { "zA", "za" }, -- toggle fold of current file
                            previous = "k",               -- preview item
                            next = "j",                   -- next item
                        },
                    })
                end,
            },
        },
        config = function()
            -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
            -- require("neodev").setup({
            --     -- add any options here, or leave empty to use the default settings
            -- })
            require("plugins.lsp.nvim-lspconfig")
        end,
    },
    {
        "SmiteshP/nvim-navic",
        config = function()
            require("nvim-navic").setup {
                highlight = true,
                click = true,
                lsp = {
                    auto_attach = true,
                    preference = nil,
                },
            }
            -- This is where I have navic all setup
            require("winbar")
            -- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
        end,
    },
    -- Winbar setup that uses navic
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        event = "LspAttach",
        config = function()
            require("fidget").setup({
                window = {
                    blend = 0,
                },
            })
        end,
    },
    -- {
    --     'utilyre/barbecue.nvim',
    --     name = 'barbecue',
    --     version = '*',
    --     dependencies = {
    --         'SmiteshP/nvim-navic',
    --         'nvim-tree/nvim-web-devicons', -- optional dependency
    --     },
    --     opts = {
    --     },
    -- },
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup()
        end,
        event = { "CmdlineEnter" },
        ft = { "go", 'gomod' },
        build =
        ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    },
}
