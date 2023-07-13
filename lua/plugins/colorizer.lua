return {
    {
        "norcalli/nvim-colorizer.lua",
        event = { "BufReadPre" },
        config = function()
            require("colorizer").setup({
                filetypes = { '*', '!lazy' },
                user_default_options = {
                    -- names = false,
                },
            })
        end,
    },
}
