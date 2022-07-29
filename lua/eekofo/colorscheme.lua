vim.cmd("set background=dark")

-- vim.g.gruvbox_flat_style = "hard"
-- vim.g.gruvbox_flat_style = "dark"
-- vim.g.gruvbox_flat_style = "light"
vim.cmd("colorscheme " .. O.colorscheme)

-- require("palenightfall").setup()

require("onedark").setup({
    function_style = "italic",
    comment_style = "italic",
    keyword_style = "italic",
    hide_inactive_statusline = true,
    dark_sidebar = false, -- BUG: not working
    dark_float = false,
    highlight_linenumber = true,
})
