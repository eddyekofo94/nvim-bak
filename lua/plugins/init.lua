require("keymaps")
require("globals")

vim.cmd("set background=dark")
return {
    {
        "folke/twilight.nvim",
        event = "VeryLazy",
        config = function()
            require("twilight").setup({})
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        event = { "BufReadPre" },
        config = function()
            require("colorizer").setup({
                filetypes = { '*', '!lazy' },
                user_default_options = {
                    names = false,
                },
            })
        end,
    },
    {
        "glepnir/template.nvim",
        cmd = { 'Template', 'TemProject' },
        config = function()
            require('template').setup({
                temp_dir = "~/.config/nvim/template",
                author = "Eddy Ekofo",
            })
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
        event = "VeryLazy",
    },
    {
        "airblade/vim-rooter",
        lazy = false,
    },
    {
        "terrortylor/nvim-comment",
        event = "VeryLazy",
        config = function()
            require("nvim_comment").setup({
                comment_empty = false,
            })
        end,
    },
    {
        -- Window Toggle
        "szw/vim-maximizer",
        event = "VeryLazy",
    },
    { "tpope/vim-surround",   event = "InsertEnter" },
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
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        event = "VeryLazy",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    -- json schema provider
    { "b0o/schemastore.nvim", event = "VeryLazy" },
    {
        "Pocco81/true-zen.nvim",
        event = "VeryLazy",
        config = function()
            require("true-zen").setup({
                integrations = {
                    feline = true, -- hide nvim-lualine (ataraxis)
                },
            })
        end,
    },
}
