return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "neovim/nvim-lspconfig" }, -- Required
            { "williamboman/mason.nvim" }, -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional
            {
                "hrsh7th/nvim-cmp",
                config = function()
                    require("plugins.lsp.completion")
                end,
            }, -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "hrsh7th/cmp-buffer" }, -- Optional
            { "hrsh7th/cmp-path" }, -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" }, -- Optional
            { "hrsh7th/cmp-cmdline" },
            { "onsails/lspkind-nvim" },
            -- Snippets
            {
                "L3MON4D3/LuaSnip",
                dependencies = {
                    "rafamadriz/friendly-snippets",
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                    end,
                },
                opts = {
                    history = true,
                    delete_check_events = "TextChanged",
                },
            }, -- Required
            { "rafamadriz/friendly-snippets" }, -- Optional
            { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
            "hrsh7th/cmp-nvim-lsp",
            -- {
            --     "folke/neodev.nvim",
            --     opts = {
            --         plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
            --         pathStrict = true,
            --     },
            -- },
            "simrat39/rust-tools.nvim",
            {
                "j-hui/fidget.nvim",
                config = function()
                    require("fidget").setup({
                        window = {
                            blend = 0,
                        },
                    })
                end,
            },
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
                        height = 15, -- height of the trouble list
                        mode = "document_diagnostics",
                        action_keys = {
                            -- key mappings for actions in the trouble list
                            close = "q", -- close the list
                            cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
                            refresh = "r", -- manually refresh
                            jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
                            jump_close = { "o" }, -- jump to the diagnostic and close the list
                            toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
                            toggle_preview = "P", -- toggle auto_preview
                            hover = "K", -- opens a small poup with the full multiline message
                            preview = "p", -- preview the diagnostic location
                            close_folds = { "zM", "zm" }, -- close all folds
                            open_folds = { "zR", "zr" }, -- open all folds
                            toggle_fold = { "zA", "za" }, -- toggle fold of current file
                            previous = "k", -- preview item
                            next = "j", -- next item
                        },
                    })
                end,
            },
        },
        config = function()
            local lspconfig = require("lspconfig")
            require("plugins.lsp.mason_lspconfig")
        end,
    },
}
