return {
  "tzachar/highlight-undo.nvim",
  config = function()
    require("highlight-undo").setup({
      duration = 500,
      undo = {
        hlgroup = "HighlightUndo",
        mode = "n",
        lhs = "u",
        map = "undo",
        opts = {},
      },
      redo = {
        hlgroup = "HighlightUndo",
        mode = "n",
        lhs = "<C-r>",
        map = "redo",
        opts = {},
      },
      highlight_for_count = true,
    })
    local colors = O.catppuccin_colors
    vim.api.nvim_set_hl(0, "HighlightUndo", { fg = colors.mantle.hex, bg = colors.overlay1.hex })
  end,
  event = { "BufReadPre" },
}
