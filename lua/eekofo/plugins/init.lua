-- Various plugins which I installed
-- Initialize plugins
require("eekofo.plugins.telescope")
require("eekofo.plugins.sessions")
require("eekofo.plugins.dashboard")
require("eekofo.plugins.web-devicons")
require("eekofo.plugins.feline")
require("eekofo.plugins.top-bufferline")
require("eekofo.plugins.gitsigns")
-- require("eekofo.plugins.nvimtree")
require("eekofo.plugins.tree_explorer")
require("eekofo.plugins.treesitter")
require("eekofo.plugins.which-key")
require("eekofo.plugins.noice")
require("eekofo.plugins.neoscroll")
require("eekofo.plugins.formatter")

-- DEFAULT configs
require("colorizer").setup()
require("surround").setup({})
require("todo-comments").setup({})
require("nvim_comment").setup()
require("fidget").setup({
    window = {
        blend = 0,
    },
})
