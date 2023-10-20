return {
  {
    "norcalli/nvim-colorizer.lua",
    -- event = { "BufReadPost", "BufNewFile" },
    event = "BufwinEnter",
    config = function()
      require("colorizer").setup({
        filetypes = {
          "*",
          "!lazy",
          "!TelescopePrompt",
          "!TelescopeResults",
          "!TelescopePreview",
        },
        lua = { names = false },
      })
    end,
  },
}
