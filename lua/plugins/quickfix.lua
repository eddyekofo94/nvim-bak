return {
  {
    "ashfinal/qfview.nvim",
    event = "UIEnter",
    opts = {},
  },
  {
    "gabrielpoca/replacer.nvim",
    opts = {},
    keys = function()
      return {
        {
          "<leader>qf",
          function()
            require("replacer").run()
          end,
        },
        {
          "<leader>qs",
          function()
            require("replacer").save()
          end,
        },
      }
    end,
  },
}
