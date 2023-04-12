return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup({
            map_cr = true, -- send closing symbol to its own line
            check_ts = true, -- use treesitter
        })
    end,
}
