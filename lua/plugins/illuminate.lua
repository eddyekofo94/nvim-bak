local config = function()
  require("illuminate").configure({
    providers = {
      "lsp",
      "treesitter",
      "regex",
    },
    delay = 100,
    filetypes_denylist = {
      "noice",
      "prompt",
      "TelescopePrompt",
      "TelescopeResults",
      "TelescopePreview",
      "telescope",
      "qf",
      "toggleterm",
      "lazy",
      "mason",
      "harpoon",
      "help",
      "coderunner",
    },
    filetypes_allowlist = {},
    modes_denylist = {},
    modes_allowlist = {},
    providers_regex_syntax_denylist = {},
    providers_regex_syntax_allowlist = {},
    under_cursor = true,
  })
  vim.api.nvim_set_hl(0, "IlluminatedWordText", { underline = true })
  vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#313244", bold = true, underline = true })
  vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#313244", underline = true })
end

return {
  "RRethy/vim-illuminate",
  config = config,
  event = "BufReadPre",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}
