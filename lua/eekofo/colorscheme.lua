local colors = O.gruvbox_colors
vim.cmd('let g:nvcode_termcolors=256')
vim.cmd("set background=dark")

--vim.cmd('colorscheme ' .. O.colorscheme)
vim.cmd("hi ErrorMsg guifg=".. colors.bright_red.." guibg=NONE")
vim.cmd("hi WarningMsg guifg=".. colors.bright_yellow.." guibg=NONE")
vim.cmd("hi Tooltip guifg=".. colors.bright_aqua.." guibg=NONE")
