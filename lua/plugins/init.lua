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
        -- search in many files and replace
        "windwp/nvim-spectre",
        cmd = { "Spectre" },
        opts = { open_cmd = "noswapfile vnew" },
    },
    -- json schema provider
    { "b0o/schemastore.nvim", event = "VeryLazy" },

    -- log highlight colours
    {
        "MTDL9/vim-log-highlighting",
        event = "VeryLazy",
        ft = "log",
    },
}
