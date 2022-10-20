vim.cmd("set background=dark")

vim.cmd("colorscheme " .. O.colorscheme)


require("onedark").setup({
    code_style = {
        comments = "italic",
        keywords = "italic",
        functions = "italic",
        strings = "none",
        variables = "none",
    },
})
