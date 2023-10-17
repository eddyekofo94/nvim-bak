return {
  {
    "linguini1/pulse.nvim",
    config = function()
      require("pulse").setup()
    end,
  },
  {
    "mvllow/stand.nvim",
    event = "VeryLazy",
    -- enabled = false,
    keys = {
      { "<leader>wse", "<cmd>StandEnable<CR>", desc = "Enable the stand timer" },
      {
        "<leader>wsn",
        "<cmd>StandNow<CR>",
        desc = "Stand, restarting the timer",
      },
      { "<leader>wsd", "<cmd>StandDisable<CR>", desc = "Disable the stand timer" },
      { "<leader>wsw", "<cmd>StandWhen<CR>", desc = "Display time remaining until next stand" },
    },
    config = function()
      require("stand").setup({
        minutes_interval = 40,
      })
    end,
  },
}
