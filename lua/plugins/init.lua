require("keymaps")
require("globals")

vim.cmd("set background=dark")
return {
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
        'notjedi/nvim-rooter.lua',
        lazy = false,
        config = function()
            require("neo-tree").setup({
                update_cwd = true,
                update_focused_file = {
                    enable = true,
                    update_cwd = true,
                },
            })
        end,
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
    -- { "tpope/vim-surround",   event = "InsertEnter" },
    { "p00f/nvim-ts-rainbow", event = "BufReadPre" },
    {
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
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
}
