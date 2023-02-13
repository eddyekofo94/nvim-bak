vim.cmd("set background=dark")

vim.cmd.colorscheme "catppuccin"
require("catppuccin").setup {
      flavour = "mocha", -- mocha, macchiato, frappe, latte
      term_colors = true,
      integrations = {
        nvimtree = true,
        cmp = true,
        gitsigns = true,
        telescope = true,
        treesitter = true
      }
    }
local colors = require('catppuccin.palettes.mocha')
vim.cmd.highlight { 'Tabline', 'guifg=' .. colors.green, 'guibg=' .. colors.mantle }
