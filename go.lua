return {
    "olexsmir/gopher.nvim",
    dependencies = { -- dependencies
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod" },
    config = function()
        -- code
        require("gopher").setup {
            commands = {
                go = "go",
                gomodifytags = "gomodifytags",
                gotests = "~/go/bin/gotests", -- also you can set custom command path
                impl = "impl",
                iferr = "iferr",
            },
        }

        local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
        -- vim.api.nvim_create_autocmd("BufWritePre", {
        --     pattern = "*.go",
        --     callback = function()
        --         require('go.format').goimport()
        --     end,
        --     group = format_sync_grp,
        -- })
        vim.api.nvim_create_autocmd('BufWritePre', {
            pattern = 'go',
            callback = function()
                vim.lsp.buf.code_action({
                    context = { only = { 'source.organizeimports' } },
                    apply = true,
                })
            end,
            group = format_sync_grp
        })
    end,
}
