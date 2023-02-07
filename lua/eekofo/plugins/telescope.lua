local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        -- prompt_prefix = " ",
        prompt_prefix = " ",
        selection_caret = "契",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            prompt_position = "top",
            horizontal = {
                mirror = false,
            },
            vertical = {
                width_padding = 0.05,
                height_padding = 1,
                preview_height = 0.5,
            },
            width = 0.95,
            preview_cutoff = 120,
            preview_width = 80,
        },
        scroll_strategy = "cycle",
        file_sorter = require("telescope.sorters").get_fuzzy_file, -- TODO: find a better file sorter (if possible)
        file_ignore_patterns = {},
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        winblend = 4, -- transparency
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
        file_previewer = require("telescope.previewers").vim_buffer_cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
        grep_previewer = require("telescope.previewers").vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
        qflist_previewer = require("telescope.previewers").qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`
        extensions = {
            fzf = {
                override_generic_sorter = false, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
            frecency = {
                show_scores = true, -- TODO: remove when satisfied
                ignore_patterns = { "*.git/*", "*/tmp/*", "*/undodir/*" },
                workspaces = {
                    ["nvim"] = "~/.config/nvim/",
                    ["dotfiles"] = "~/.files/",
                },
            },
            media_files = {
                filetypes = { "png", "webp", "jpg", "jpeg" },
                find_cmd = "rg", -- find command (defaults to `fd`)
            },
        },
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["<esc>"] = actions.close,
                -- Add up multiple actions
                ["<CR>"] = actions.select_default + actions.center,
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            },
        },
    },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("project")
require("telescope").load_extension("frecency")
require("telescope").load_extension("zoxide")
require("telescope").load_extension("media_files") -- TODO: install a previewer eg: pip install ueberzug
