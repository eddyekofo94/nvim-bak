return {
    "beauwilliams/focus.nvim",
    event = "WinEnter",

    keys = {
        {
            "<leader>vj",
            "<cmd>FocusSplitDown<cr>",
            desc = "Split Down",
        },
        {
            "<leader>ve",
            "<cmd>FocusEnable<cr>",
            desc = "Focus Enable",
        },
        {
            "<leader>vh",
            "<cmd>FocusSplitLeft<cr>",
            desc = "Split Left",
        },
        {
            "<leader>vt",
            "<cmd>FocusToggle<cr>",
            desc = "Focus Toggle",
        },
        {
            "<leader>vl",
            "<cmd>FocusSplitRight<cr>",
            desc = "Split Right",
        },
        {
            "<leader>m",
            "<cmd>FocusSplitCycle<cr>",
            desc = "Move next buffer",
        },
        {
            '<leader>\\',
            "<cmd>FocusAutoresize<cr>",
            desc = "Activate autoresise",

        },
        {
            "<leader>vk",
            "<cmd>FocusSplitUp<cr>",
            desc = "Split Right",
        },
        {
            "<leader>t",
            "<cmd>FocusSplitNicely cmd term<cr>",
            desc = "Terminal",
        },
        -- {
        --     "<leader>|",
        --     "<cmd>FocusSplitNicely<cr>",
        --     desc = "Split Nicely",
        -- },
        {
            "<leader>vv",
            "<cmd>FocusSplitNicely<cr>",
            desc = "Split Nicely",
        },
        {
            "<leader>w",
            "<cmd>FocusMaxOrEqual<cr>",
            desc = "Max window",
        },
        {
            "<leader>-", "<cmd>FocusSplitDown<CR>", desc = "split horizontally",
        },
        {
            "<leader>=", "<cmd>FocusEqualise<CR>", desc = "balance windows",
        },
    },
    config = function()
        require("focus").setup(
            {
                enable = true,
                signcolumn = false,
                excluded_filetypes = { "neo-tree", "telescope", "toggleterm" },
                compatible_filetrees = { "neo-tree" },
                ui = {
                    number = true,         -- Display line numbers in the focussed window only
                    relativenumber = true, -- Display relative line numbers in the focussed window only
                    hybridnumber = true,   -- Display hybrid line numbers in the focussed window only
                    -- BUG: This seems to not be working
                    winhighlight = true,   -- Auto highlighting for focussed/unfocussed windows
                    cursorline = true,     -- Display a cursorline in the focussed window only
                },
            }
        )
    end,
}
