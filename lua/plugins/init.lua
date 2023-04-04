require("autocommands")
require("keymaps")
require("globals")

return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            vim.cmd.colorscheme("catppuccin")
            require("catppucin_mocha")
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        event = "VeryLazy",
    },
    {
        "folke/twilight.nvim",
        event = "VeryLazy",
        config = function()
            require("twilight").setup({})
        end,
    },
    {

        "norcalli/nvim-colorizer.lua",
        event = { "VeryLazy" },
        config = function()
            require("colorizer").setup()
        end,
    },
    {
        "ur4ltz/surround.nvim",
        event = { "VeryLazy" },
        config = function()
            require("surround").setup({ mappings_style = "surround" })
        end,
    },
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("todo-comments").setup({})
        end,
    },
    {
        "mbbill/undotree",
    },
    {
        "airblade/vim-rooter",
    },
    {

        "terrortylor/nvim-comment",
        event = "VeryLazy",
        config = function()
            require("nvim_comment").setup()
        end,
    },
    {
        --         -- Window Toggle
        "szw/vim-maximizer",
        event = "VeryLazy",
    },
    { "tpope/vim-surround", event = "InsertEnter" },
    { "p00f/nvim-ts-rainbow", event = "BufReadPre" },
    {
        "glepnir/lspsaga.nvim",
        event = "VeryLazy",
        config = function()
            require("lspsaga").setup({})
        end,
        dependencies = { { "nvim-tree/nvim-web-devicons" } },
    },
    {
        "nvim-neorg/neorg",
        event = "VeryLazy",
        build = ":Neorg sync-parsers",
        opts = {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.presenter"] = {
                    config = {
                        zen_mode = "truezen",
                    },
                }, -- Adds pretty icons to your documents
                ["core.norg.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                        name = "[Neorg]",
                    },
                },
                ["core.export.markdown"] = {},
                ["core.export"] = {
                    config = {
                        export_dir = "~/notes/exports",
                    },
                },
                ["core.norg.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                    },
                },
            },
        },
        dependencies = { { "nvim-lua/plenary.nvim" } },
    },
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        event = "VeryLazy",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    {
        "Pocco81/true-zen.nvim",
        event = "VeryLazy",
        config = function()
            require("true-zen").setup({
                integrations = {
                    lualine = true, -- hide nvim-lualine (ataraxis)
                },
            })
        end,
    },
}
