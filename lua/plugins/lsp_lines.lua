return {
  -- LSP VIRTUAL TEXT
  "Maan2003/lsp_lines.nvim",
  enabled = false,
  event = "LspAttach",
  config = function()
    require("lsp_lines").setup()
    local keymap_set = require("utils").keymap_set
    keymap_set("n", "<Leader>dl", require("lsp_lines").toggle, "Toggle lsp_lines")
    -- disable virtual_text since it's redundant due to lsp_lines.
    vim.diagnostic.config({ virtual_text = false })
  end,
}
