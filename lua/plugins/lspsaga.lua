return {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    keys = {
        {
            "K",
            "<cmd>Lspsaga hover_doc<CR>",
            desc = "Saga hover",
        },
        {
            "]d",
            "<cmd>Lspsaga diagnostic_jump_next<cr>",
            desc = "diagnostic jump next"
        },
        {
            "[d",
            "<cmd>Lspsaga diagnostic_jump_prev<cr>",
            desc = "diagnostic jump prev"
        }
    },
    config = function()
        require("lspsaga").setup({})
        -- local mapper = require("utils").mapper

        -- mapper("n", "gd", "<cmd>Lspsaga finder<CR>")
        -- mapper("n", "K", "<cmd>Lspsaga hover_doc<CR>")
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
