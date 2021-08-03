-- Various plugins which I installed
-- Initialize plugins
require("eekofo.plugins.telescope")
require("eekofo.plugins.sessions")
require("eekofo.plugins.dashboard")
require("eekofo.plugins.web-devicons")
require("eekofo.plugins.autopairs")
require("eekofo.plugins.feline")
require("eekofo.plugins.top-bufferline")
require("eekofo.plugins.gitsigns")
require("eekofo.plugins.nvimtree")
require("eekofo.plugins.treesitter")
require("eekofo.plugins.which-key")
require("eekofo.plugins.dap")
require("eekofo.plugins.fterm")
-- require("eekofo.plugins.indent_blankline")
require("eekofo.plugins.neoscroll")
require("colorizer").setup()
require("FTerm").setup()
require("surround").setup({})
require("todo-comments").setup({})
-- nvim-comment
require("nvim_comment").setup()

-- Have Neoformat only msg when there is an error
vim.g.neoformat_only_msg_on_error = 1
-- Enable tab to spaces conversion
vim.g.neoformat_basic_format_retab = 1

-- Make Ranger to be hidden after picking a file
vim.g.rnvimr_enable_picker = 1
