return {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
        require("lspsaga").setup({})
        local mapper = require("utils").mapper

        -- mapper("n", "gd", "<cmd>Lspsaga finder<CR>")
        mapper("n", "K", "<cmd>Lspsaga hover_doc<CR>")
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
