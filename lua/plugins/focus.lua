return
{
    "beauwilliams/focus.nvim",
    event = "WinEnter",
    opts = {
        enable = true,
        signcolumn = false,
        excluded_filetypes = { "toggleterm" },
        compatible_filetrees = { "neo-tree" },
    },
    config = function(_, opts)
        require("focus").setup(opts)
    end,
    keys = {
        {
            "<Leader>sl",
            function()
                require("focus").split_command("h")
            end,
            desc = "[S]plit window [l]eft",
        },
        {
            "<Leader>sr",
            function()
                require("focus").split_command("l")
            end,
            desc = "[S]plit window [r]ight",
        },
    },
}
