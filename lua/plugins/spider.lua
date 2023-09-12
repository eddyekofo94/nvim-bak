local keymaps = require 'utils.keymaps'
local treesitter_fts
local set = require("utils").keymap_set
local nxo = require("utils").nxo

return {
    'chrisgrieser/nvim-spider',
    opts = {
        skipInsignificantPunctuation = true,
    },
    keys = { 'w', 'e', 'b', 'ge' },
    config = function()
        -- set(nxo, "w", "<cmd>lua require('spider').motion('w')<CR>",
        --  "Spider-w" )
        -- set(nxo, "e", "<cmd>lua require('spider').motion('e')<CR>",
        --  "Spider-e" )
        -- set(nxo, "b", "<cmd>lua require('spider').motion('b')<CR>",
        --  "Spider-b" )
        -- set(nxo, "ge", "<cmd>lua require('spider').motion('ge')<CR>",
        --     { desc = "Spider-ge" })

        for _, i in ipairs { 'w', 'e', 'b', 'ge' } do
            keymaps.confusing(nxo, i,
                function()
                    if not treesitter_fts then
                        treesitter_fts =
                            vim.tbl_keys(
                                require 'nvim-treesitter.parsers'.get_parser_configs()
                            )
                    end
                    if treesitter_fts[vim.bo.ft] then
                        require('spider').motion(i)
                        return ''
                    end
                    return i
                end,
                {
                    desc = 'Spider-' .. i,
                    expr = true,
                }
            )
        end
    end,
}
