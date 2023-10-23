-- return {}
return {
  "nvim-zh/colorful-winsep.nvim",
  enable = true,
  event = { "WinNew" },
  opts = {
    highlight = {
      bg = vim.api.nvim_get_hl(0, { name = "Normal" })["background"],
      fg = "#c099ff",
    },
    -- interval = 50,
    no_exec_files = { "noice", "notify", "TelescopePrompt" },

    --  NOTE: 2023-10-23 13:03 PM - "⎯"
    symbols = { "─", "│", "┌", "┐", "└", "┘" },
    -- disable if I only have 2 files open
    create_event = function()
      local winsep = require("colorful-winsep")
      local win_handles = vim.api.nvim_list_wins()
      local num_visible = 0
      for _, handle in ipairs(win_handles) do
        local win_config = vim.api.nvim_win_get_config(handle)
        if win_config["focusable"] then
          num_visible = num_visible + 1
        end
      end
      if num_visible < 3 then
        winsep.NvimSeparatorDel()
      end
    end,
  },
}
