return {
    "feline-nvim/feline.nvim",
    lazy = false,
    config = function()
        local catpuccin = require("catppuccin.groups.integrations.feline")

        catpuccin.setup({
            force_inactive = {
                filetypes = {
                    "packer",
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

        local properties = {
            force_inactive = {
                filetypes = {
                    "packer",
                    "^neo-tree$",
                    "neo%-tree",
                    "dap-repl",
                    "dapui_scopes",
                    "dapui_stacks",
                    "dapui_watches",
                    "dapui_repl",
                    "LspTrouble",
                    "qf",
                    "help",
                },
                buftypes = { "terminal", "neo-tree" },
                bufnames = {},
            },
            disable = {
                filetypes = {
                    "dashboard",
                    "startify",
                    "neo-tree",
                },
            },
        }

        require("feline").winbar.setup()
        require("feline").setup({
            components = catpuccin.get(),
            properties = properties,
        })
    end,
}
