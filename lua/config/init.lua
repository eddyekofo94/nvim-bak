M = {}
M.telescope = function()
    require("plugins.plugin_configs.telescope")
end
M.which_key = function()
    require("plugins.plugins_configs.which_key")
end

M.treesitter = function()
    require("plugins.plugins_configs.treesitter")
end
return M
