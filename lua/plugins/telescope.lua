local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case"
        },
        prompt_position = "top",
        prompt_prefix = "❯ ",
        selection_caret = "❯ ",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_defaults = {
            horizontal = {
                width_padding = 0.1,
                height_padding = 0.1,
                preview_width = 0.6
            },
            vertical = {
                width_padding = 0.05,
                height_padding = 1,
                preview_height = 0.5
            }
        },
        scroll_strategy = "cycle",
        file_sorter = require "telescope.sorters".get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require "telescope.sorters".get_generic_fuzzy_sorter,
        shorten_path = true,
        winblend = 0, -- transparency
        width = 0.75,
        preview_cutoff = 120,
        results_height = 1,
        results_width = 0.8,
        border = {},
        borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
        color_devicons = true,
        use_less = true,
        set_env = {["COLORTERM"] = "truecolor"}, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
        file_previewer = require "telescope.previewers".vim_buffer_cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
        grep_previewer = require "telescope.previewers".vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
        qflist_previewer = require "telescope.previewers".qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`
        extensions = {
            fzf = {
                override_generic_sorter = false, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case" -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            }
        },
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["<esc>"] = actions.close,
                -- Add up multiple actions
                ["<CR>"] = actions.select_default + actions.center
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist
            }
        }
    }
}

require('telescope').load_extension('fzf')
