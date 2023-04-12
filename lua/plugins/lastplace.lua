---------------
-- Lastplace --
---------------
return {
    "ethanholz/nvim-lastplace",
    event = "BufReadPre",
    config = function()
        require("nvim-lastplace").setup({
            lastplace_ignore_filetype = { "gitcommit" },
        })
    end,
}
