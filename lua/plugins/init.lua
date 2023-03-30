M = {}
-- Various plugins which I installed
-- -- Initialize plugins
-- require("eekofo.plugins.telescope")
-- require("eekofo.plugins.sessions")
-- require("eekofo.plugins.dashboard")
-- require("eekofo.plugins.web-devicons")
-- require("eekofo.plugins.feline")
-- require("eekofo.plugins.top-bufferline")
-- require("eekofo.plugins.gitsigns")
-- -- require("eekofo.plugins.nvimtree")
-- require("eekofo.plugins.tree_explorer")
-- require("eekofo.plugins.treesitter")
-- require("eekofo.plugins.which-key")
-- require("eekofo.plugins.noice")
-- require("eekofo.plugins.neoscroll")
-- require("eekofo.plugins.formatter")
--
-- -- DEFAULT configs
-- require("colorizer").setup()
-- require("surround").setup({})
-- require("todo-comments").setup({})
-- require("nvim_comment").setup()
-- require("fidget").setup({
--     window = {
--         blend = 0,
--     },
-- })

--local lsp = require("plugins.lsp")
M.lsp_config = function()
    require("plugins.lsp")
end
M.telescope = function()
    require("plugins.telescope")
end
M.which_key = function()
    require("plugins.which-key")
end

M.neo_tree = function()
    require("plugins.neotree")
end
M.treesitter = function()
    require("plugins.treesitter")
end

M.mason_lspconfig = function ()
    require("plugins.lsp").mason_lspconfig()
end

M.cmp = function ()
   require("plugins.lsp.cmp")
end

return M
