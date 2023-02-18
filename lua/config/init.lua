local cfg = require("plugins")
require("autocommands")

--local lsp = require("plugins.lsp")
-- which-key
return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd.colorscheme("catppuccin")
            require("colorscheme")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        build = ":TSUpdate",
        dependencies = {

            "nvim-treesitter/nvim-treesitter-context",
            "nvim-treesitter/nvim-treesitter-textobjects",

            "windwp/nvim-ts-autotag",
        },
        config = cfg.treesitter,
    },
    {

        "terrortylor/nvim-comment",
        event = "VeryLazy",
        config = function()
            require("nvim_comment").setup()
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = { spelling = true },
        },
        config = cfg.which_key,
    },
    { "williamboman/mason.nvim" },
    {

        --         -- Window Toggle
        "szw/vim-maximizer",
        event = "VeryLazy",
    },
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
            { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
    },
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {

            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-telescope/telescope-project.nvim",
            "nvim-telescope/telescope-frecency.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "jvgrootveld/telescope-zoxide",
            "tami5/sql.nvim",
        },
        version = false, -- telescope did only one release, so use HEAD for now
        config = cfg.telescope,
    },
    {
        "mhartington/formatter.nvim",
        event = "VeryLazy",
        --cmd = "Format",
        config = function()
            require("plugins.formatter")
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        -- load cmp on InsertEnter
        event = "InsertEnter",
        -- these dependencies will only be loaded when cmp loads
        -- dependencies are always lazy-loaded unless specified otherwise
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
        },

        config = function()
            -- ...
            -- for completion
            require("plugins.lsp.cmp")
        end,
    },
}
