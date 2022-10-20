vim.cmd("set background=dark")

vim.cmd("colorscheme " .. O.colorscheme)


require("onedark").setup({
    style = "dark",
    code_style = {
        comments = "italic",
        keywords = "italic",
        functions = "italic",
        strings = "none",
        variables = "none",
    },
})

require('onedark').load()
