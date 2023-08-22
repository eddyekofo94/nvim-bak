return {
    "beauwilliams/focus.nvim",
    event = "WinEnter",
    config = function()
        require("focus").setup(
            {
                enable = true,
                signcolumn = false,
                excluded_filetypes = { "toggleterm" },
                compatible_filetrees = { "neo-tree" },
                ui = {
                    number = true, -- Display line numbers in the focussed window only
                    relativenumber = true, -- Display relative line numbers in the focussed window only
                    hybridnumber = true, -- Display hybrid line numbers in the focussed window only
                    winhighlight = true, -- Auto highlighting for focussed/unfocussed windows
                    -- BUG: this seems broken
                    cursorline = true, -- Display a cursorline in the focussed window only
                },
            }
        )
    end,
}
