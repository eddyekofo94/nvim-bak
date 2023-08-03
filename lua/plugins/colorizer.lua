return {
    {
        "norcalli/nvim-colorizer.lua",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("colorizer").setup({
                filetypes = { '*', '!lazy' },
                lua = { names = false },
            })
        end,
    },
}
