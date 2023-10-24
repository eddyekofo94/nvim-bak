return {
  {
    -- NULL-LS
    "nvimtools/none-ls.nvim", -- "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        debug = true,
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins
        diagnostics_format = "#{m} (#{s})",
        diagnostic_config = {
          virtual_text = {
            prefix = "○ ",
            severity_limit = "Warning",
            spacing = 8,
          },
          signs = true,
          update_in_insert = true,
        },
        sources = {
          null_ls.builtins.code_actions.shellcheck, -- https://www.shellcheck.net/
          null_ls.builtins.diagnostics.shellcheck.with({
            diagnostics_format = "[#{c}] #{m} (#{s})",
            diagnostic_config = {
              virtual_text = {
                prefix = "  ",
                severity_limit = "Warning",
                spacing = 8,
              },
              signs = true,
              update_in_insert = true,
            },
          }),
          null_ls.builtins.diagnostics.checkmake, -- https://github.com/mrtazz/checkmake
          -- null_ls.builtins.diagnostics.codespell,
          --  INFO: 2023-10-11 - install pip3 install codespell
          require("null-ls").builtins.diagnostics.codespell.with({
            extra_args = { "-L", "noice,crate" },
          }), -- https://github.com/codespell-project/codespell
          null_ls.builtins.diagnostics.golangci_lint, -- https://github.com/golangci/golangci-lint (~/.golangci.yml)
          null_ls.builtins.completion.spell,
          -- require("null-ls").builtins.diagnostics.semgrep.with({
          --   args = { "--config", "auto", "-q", "--json", "$FILENAME" },
          --   method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
          --   timeout = 30000 -- 30 seconds
          -- }), -- https://semgrep.dev/
          --  BUG: 2023-10-18 - This is breaking things up! disabled for NOW!
          -- null_ls.builtins.diagnostics.staticcheck, -- https://github.com/dominikh/go-tools
          null_ls.builtins.diagnostics.write_good, -- https://github.com/btford/write-good
          -- null_ls.builtins.diagnostics.zsh, -- https://www.zsh.org/ (uses zsh command's -n option to evaluate code, not execute it)
          null_ls.builtins.formatting.black, -- https://github.com/psf/black
          null_ls.builtins.formatting.autopep8, -- https://github.com/hhatto/autopep8
          -- DISABLED: Because it auto-formats code and ends up breaking code.
          -- null_ls.builtins.formatting.codespell,                   -- https://github.com/codespell-project/codespell
          null_ls.builtins.formatting.fixjson, -- https://github.com/rhysd/fixjson
          null_ls.builtins.formatting.goimports_reviser, -- https://pkg.go.dev/github.com/incu6us/goimports-reviser
          null_ls.builtins.formatting.isort, -- https://github.com/PyCQA/isort
          null_ls.builtins.formatting.lua_format, -- https://github.com/Koihik/LuaFormatter
          null_ls.builtins.formatting.markdown_toc, -- https://github.com/jonschlinkert/markdown-toc
          null_ls.builtins.formatting.mdformat, -- https://github.com/executablebooks/mdformat
          null_ls.builtins.formatting.ocdc, -- https://github.com/mdwint/ocdc
          null_ls.builtins.formatting.shfmt, -- https://github.com/mvdan/sh
          null_ls.builtins.formatting.taplo, -- https://taplo.tamasfe.dev/
          null_ls.builtins.formatting.terraform_fmt, -- https://www.terraform.io/docs/cli/commands/fmt.html
          null_ls.builtins.formatting.yamlfmt, -- https://github.com/google/yamlfmt
        },
      })
    end,
  },
}
