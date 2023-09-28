-- INFO: This seems to not be working, but I want it to
return {
    "smjonas/inc-rename.nvim",
    event = "LspAttach",
    config = true,
    keys = {
        {
            "<leader>lr",
            function()
                return "<cmd>IncRename " .. vim.fn.expand("<cword>")
            end,
            {
                expr = true,
                desc = "Rename",
            },
        }
    },
}
