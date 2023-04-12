return {
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        module = "persistence",
        opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
    },
    { "nvim-lua/plenary.nvim", lazy = true },
}
