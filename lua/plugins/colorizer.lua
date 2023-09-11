return {
    {
        "norcalli/nvim-colorizer.lua",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("colorizer").setup({
                filetypes = {
                    "*",
                    "!lazy",
                    "!TelescopePrompt",
                    "!TelescopeResults",
                    "!TelescopePreview",
                },
                lua = { names = false },
            })
        end,
    },
}
