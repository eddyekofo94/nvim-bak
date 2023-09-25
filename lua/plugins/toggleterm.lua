-- INFO: This seems to break Lazygit, we can't have that
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  enable = true,
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    start_in_insert = true,
    insert_mappings = true,
    direction = "float",
    close_on_exit = true,
  },
  cmd = "ToggleTerm",
  keys = {
    {
      "<A-i>",
      vim.cmd.ToggleTerm,
      mode = { "n", "t" },
      desc = "Toggle terminal",
    },
    -- {
    --     "<leader>t",
    --     "<cmd>ToggleTerm direction=vertical<cr>",
    --     mode = { 'n', 't' },
    --     desc = "Terminal",
    -- }
  },
}
