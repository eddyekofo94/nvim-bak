return
{
    "beauwilliams/focus.nvim",
    event = "WinEnter",
    opts = {
        enable = true,
        signcolumn = false,
        excluded_filetypes = { "toggleterm" },
        -- compatible_filetrees = { "neo-tree" },
    },
    config = function(_, opts)
        require("focus").setup(opts)
    end,
}
