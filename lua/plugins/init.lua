M = {}
-- Various plugins which I installed
-- -- Initialize plugins
-- require("plugins.dashboard") [NOT SURE]
-- require("plugins.top-bufferline")
--
-- -- DEFAULT configs
-- require("surround").setup({})
-- require("fidget").setup({ [BUG:]
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

M.cmp = function ()
   require("plugins.lsp.cmp")
end
M.gitsigns = function ()
   require("plugins.gitsigns")
end

return M
