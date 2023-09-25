return {
  "kevinhwang91/nvim-ufo",
  enabled = false,
  event = { "BufRead" },
  dependencies = {
    { "kevinhwang91/promise-async" },
    { "nvim-treesitter/nvim-treesitter" },
  },
  opts = {
    provider_selector = function(_, _, _)
      return { "treesitter", "indent" }
    end,
  },
}
