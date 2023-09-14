-- references:
-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes
return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        {
            -- only needed if you want to use the commands with "_with_window_picker" suffix
            's1n7ax/nvim-window-picker',
            config = function()
                require 'window-picker'.setup({
                    autoselect_one = true,
                    include_current = false,
                    filter_rules = {
                        -- filter using buffer options
                        bo = {
                            -- if the file type is one of following, the window will be ignored
                            filetype = { 'neo-tree', "neo-tree-popup", "notify" },

                            -- if the buffer type is one of following, the window will be ignored
                            buftype = { 'terminal', "quickfix" },
                        },
                    },
                    other_win_hl_color = 'MatchParenCur',
                })
            end,
        },
    },
    event = "VeryLazy",
    keys = {
        {
            "<leader>e",
            ":Neotree source=filesystem reveal=true position=right toggle=true<CR>",
            silent = true,
            desc = "File Explorer",
        },
    },
    config = function()
        require("neo-tree").setup({
            mappings = {
                ["<space>"] = {
                    "toggle_node",
                    nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
                },
                ["<cr>"] = "open",
                ["l"] = "open",
                ["S"] = "open_split",
                ["s"] = "open_vsplit",
                -- ["S"] = "split_with_window_picker",
                -- ["s"] = "vsplit_with_window_picker",
                ["t"] = "open_tabnew",
                ["w"] = "open_with_window_picker",
                ["C"] = "close_node",
                ["a"] = {
                    "add",
                    -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                    config = {
                        show_path = "none", -- "none", "relative", "absolute"
                    },
                },
                ["A"] = "add_directory", -- also accepts the config.show_path option.
                ["d"] = "delete",
                ["r"] = "rename",
                ["y"] = "copy_to_clipboard",
                ["x"] = "cut_to_clipboard",
                ["p"] = "paste_from_clipboard",
                ["c"] = "copy", -- takes text input for destination
                ["m"] = "move", -- takes text input for destination
                ["q"] = "close_window",
                ["R"] = "refresh",
                ["?"] = "show_help",
            },
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "󰜌",
                -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                -- then these will never be used.
                default = "*",
                highlight = "NeoTreeFileIcon",
            },
        })
    end,
}
