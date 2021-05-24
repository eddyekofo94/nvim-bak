local colors = O.gruvbox_colors
vim.cmd('let g:nvcode_termcolors=256')
vim.cmd("set background=dark")

--vim.cmd('colorscheme ' .. O.colorscheme)
vim.cmd("hi ErrorMsg guifg=".. colors.red.." guibg=NONE")
vim.cmd("hi WarningMsg guifg=".. colors.yellow.." guibg=NONE")
vim.cmd("hi Tooltip guifg=".. colors.aqua.." guibg=NONE")

-- vim.g.gruvbox_flat_style = "dark"
