return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<leader>T", "<cmd>TodoQuickFix<cr>", desc = "Search TODO" },
    { "]t", "<cmd>lua require('todo-comments').jump_next()<cr>", { desc = "Next todo comment" } },
    { "[t", "<cmd>lua require('todo-comments').jump_prev()<cr>", { desc = "Previous todo comment" } },
  },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    keywords = {
      FIX = {
        icon = " ", -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "ERROR" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "REFACTOR", "REFC", "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO", "REVIEW" } },
      EXAMPLE = { icon = "󰄛 ", color = "hint", alt = { "E.G." } },
      CLEAN_UP = { icon = " ", color = "error", alt = { "CLEAN" } },
      DEBUG = { icon = " ", color = "error" },
      TEST = { icon = "󰙨 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
  },
}
