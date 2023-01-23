local actions = require("telescope.actions")
return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        selection_caret = "契",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        color_devicons = true,
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
          preview_cutoff = 90,
          preview_width = 110,
        },
        scroll_strategy = "cycle",
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
    },
  },
}
