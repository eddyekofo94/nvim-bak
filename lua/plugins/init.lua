require("keymaps")
require("globals")
-- require("statusline")

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
        "chrisgrieser/nvim-early-retirement",
        config = true,
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
    {
        -- search in many files and replace
        "windwp/nvim-spectre",
        cmd = { "Spectre" },
        opts = { open_cmd = "noswapfile vnew" },
    },
    {
        "j-hui/fidget.nvim",
        version = "legacy",
        config = function()
            require("fidget").setup({
                window = {
                    blend = 0,
                },
            })
        end,
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
        "norcalli/nvim-terminal.lua",
        config = function()
            require("terminal").setup()
        end,
    },
    -- json schema provider
    { "b0o/schemastore.nvim",       event = "VeryLazy" },
    { "MTDL9/vim-log-highlighting", event = "VeryLazy" },
}
