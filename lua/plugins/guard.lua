return {
  "nvimdev/guard.nvim",
  -- Builtin configuration, optional
  dependencies = {
    "nvimdev/guard-collection",
  },
  enabled = false,
  config = function()
    local ft = require("guard.filetype")
    ft("lua"):fmt("lsp"):append("stylua"):lint("selene")
    ft("cpp"):fmt("clang-format"):lint("clang-tidy")
    ft("go"):fmt("gofmt"):append("golines")
    ft("zsh"):fmt("shfmt")

    require("guard").setup({
      -- the only options for the setup function
      fmt_on_save = true,
      -- Use lsp if no formatter was defined for this filetype
      lsp_as_default_formatter = false,
    })
  end,
}
