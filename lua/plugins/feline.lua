return {
    "feline-nvim/feline.nvim",
    dependencies = {
        "catppuccin/nvim",
    },
    lazy = false,
    config = function()
        local catpuccin = require("catppuccin.groups.integrations.feline")

        catpuccin.setup({
            force_inactive = {
                filetypes = {
                    "packer",
                    "dashboard",
                    "neo-tree",
                    "dap-repl",
                    "dapui_scopes",
                    "dapui_stacks",
                    "dapui_watches",
                    "dapui_repl",
                    "LspTrouble",
                    "qf",
                    "help",
                },
            },
            disable = {
                filetypes = {
                    "dashboard",
                    "startify",
                    "neo-tree",
                },
            },
        })

        -- require("feline").winbar.setup()
        require("feline").setup({
            components = catpuccin.get(),
        })
    end,
}
