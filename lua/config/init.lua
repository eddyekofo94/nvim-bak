local cfg = require("plugins")
require("autocommands")
require("keymappings")

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
        "kdheepak/lazygit.nvim",
        event = "VeryLazy",
    },
    {
        --    better session management in neovim
        "rmagatti/auto-session",
        config = function()
            require("plugins.sessions")
        end,
    },
    {
        "folke/twilight.nvim",
        config = function()
            require("twilight").setup({})
        end,
    },
    {
        -- git signs
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("plugins.gitsigns")
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
        "nvim-neo-tree/neo-tree.nvim",
        event = "VeryLazy",
        dependencies = {

            { "s1n7ax/nvim-window-picker", version = "v1.*" },
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        },
    },
    {

        "norcalli/nvim-colorizer.lua",
        event = { "VeryLazy" },
        config = function()
            require("colorizer").setup()
        end,
    },
    {

        "karb94/neoscroll.nvim",
        event = { "VeryLazy" },
        config = function()
            require("plugins.neoscroll")
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
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = { spelling = true },
        },
        config = cfg.which_key,
    },
    {
        --         -- Window Toggle
        "szw/vim-maximizer",
        event = "VeryLazy",
    },
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {

            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            {
                "nvim-telescope/telescope-project.nvim",
                config = function()
                    require("telescope").load_extension("project")
                end,
            },
            {
                "nvim-telescope/telescope-frecency.nvim",
                config = function()
                    require("telescope").load_extension("frecency")
                end,
            },
            {
                "jvgrootveld/telescope-zoxide",
                config = function()
                    require("telescope").load_extension("zoxide")
                end,
            },
            "tami5/sql.nvim",
        },
        version = false, -- telescope did only one release, so use HEAD for now
        config = function()
            cfg.telescope()
        end,
    },
    {
        "telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            config = function()
                require("telescope").load_extension("fzf")
            end,
            {

                "rmagatti/session-lens",
                config = function()
                    require("telescope").load_extension("session-lens")
                end,
            },
        },
    },
    {
        "feline-nvim/feline.nvim",
        config = function()
            require("plugins.feline")
        end,
    },
    {
        "folke/noice.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("plugins.noice")
        end,
        dependencies = {
            "rcarriga/nvim-notify",
            "MunifTanjim/nui.nvim",
        },
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
        config = function()
            cfg.cmp()
        end,
        -- load cmp on InsertEnter
        event = "InsertEnter",
        -- these dependencies will only be loaded when cmp loads
        -- dependencies are always lazy-loaded unless specified otherwise
        dependencies = {
            "ray-x/lsp_signature.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",

            -- TODO: Find a way to fix this autopair { "windwp/nvim-autopairs",
            --     config = function()
            --         require("plugins.autopairs")
            --     end,
            -- },
            "saadparwaiz1/cmp_luasnip",
            {
                "onsails/lspkind-nvim",
                event = "VeryLazy",
                config = function()
                    _ = require("lspkind").init()
                end,
            },
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
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
                -- stylua: ignore
                keys = {
                    {
                        "<tab>",
                        function()
                            return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                        end,
                        expr = true,
                        silent = true,
                        mode = "i",
                    },
                    {
                        "<tab>",
                        function()
                            require("luasnip").jump(1)
                        end,
                        mode = "s",
                    },
                    {
                        "<s-tab>",
                        function()
                            require("luasnip").jump(-1)
                        end,
                        mode = { "i", "s" },
                    },
                },
            },
        },
    },
}
