return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {

            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                config = function()
                    require("telescope").load_extension("fzf")
                end,
            },
            {
                "nvim-telescope/telescope-project.nvim",
                config = function()
                    require("telescope").load_extension("project")
                end,
            },
            {
                "nvim-telescope/telescope-frecency.nvim",
                config = function()
                    require("telescope").load_extension("frecency")
                end,
            },
            {
                "jvgrootveld/telescope-zoxide",
                config = function()
                    require("telescope").load_extension("zoxide")
                end,
            },
            "tami5/sql.nvim",
        },
        version = false, -- telescope did only one release, so use HEAD for now
        config = function()
            local cfg_telescope = require("telescope")
            local actions = require("telescope.actions")
            local Util = require("utils")

            cfg_telescope.setup({
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                    prompt_prefix = " ",
                    selection_caret = "契",
                    path_display = { "truncate" },
                    selection_strategy = "reset",
                    sorting_strategy = "descending",
                    layout_strategy = "horizontal",
                    layout_config = {
                        prompt_position = "bottom",
                        horizontal = {
                            prompt_position = "bottom",
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.95,
                        preview_cutoff = 120,
                        height = 80,
                    },
                    pickers = {
                        buffers = {
                            sort_mru = true,
                            ignore_current_buffer = true,
                            mappings = {
                                i = {
                                    ["<c-d>"] = "delete_buffer", -- this overrides the built in preview scroller
                                    ["<c-b>"] = "preview_scrolling_down",
                                },
                                n = {
                                    ["<c-d>"] = "delete_buffer", -- this overrides the built in preview scroller
                                    ["<c-b>"] = "preview_scrolling_down",
                                },
                            },
                        },
                    },
                    scroll_strategy = "cycle",
                    dynamic_preview_title = true,
                    file_sorter = require("telescope.sorters").get_fzy_sorter,                -- TODO: find a better file sorter (if possible)
                    generic_sorter = require("telescope.sorters").fuzzy_with_index_bias,
                    winblend = 0,                                                             -- transparency
                    use_less = true,
                    set_env = { ["COLORTERM"] = "truecolor" },                                -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,      -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
                    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,  -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
                    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`
                    extensions = {
                        -- persisted = {
                        --     layout_config = { width = 0.55, height = 0.55 },
                        -- },
                        fzf = {
                            fuzzy = true,                   -- let me make typos in file names please
                            override_generic_sorter = true, -- override the generic sorter
                            override_file_sorter = true,    -- override the file sorter
                            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                        },
                        frecency = {
                            show_scores = true, -- TODO: remove when satisfied
                            ignore_patterns = { "*.git/*", "*/tmp/*", "*/undodir/*" },
                            workspaces = {
                                ["nvim"] = "~/.config/nvim/",
                                ["dotfiles"] = "~/.dotfiles/",
                            },
                        },
                    },
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                            ["<esc>"] = actions.close,
                            ["<C-x>"] = actions.select_horizontal,
                            ["<C-v>"] = actions.select_vertical,
                            ["<C-Down>"] = require("telescope.actions").cycle_history_next,
                            ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
                            ["<C-t>"] = actions.select_tab,
                            ["<C-f>"] = actions.preview_scrolling_down,
                            ["<C-b>"] = actions.preview_scrolling_up,
                            -- Add up multiple actions
                            ["<CR>"] = actions.select_default + actions.center,
                            ["<a-i>"] = function()
                                Util.telescope("find_files", { no_ignore = true })()
                            end,
                            ["<a-h>"] = function()
                                Util.telescope("find_files", { hidden = true })()
                            end,
                        },
                        n = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                            ["H"] = actions.move_to_top,
                            ["M"] = actions.move_to_middle,
                            ["L"] = actions.move_to_bottom,
                            ["gg"] = actions.move_to_top,
                            ["G"] = actions.move_to_bottom,
                            ["q"] = actions.close,
                        },
                    },
                },
            })
        end,
    },
}
