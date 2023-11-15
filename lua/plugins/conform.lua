return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  config = function()
    require("conform").setup({
      -- Map of filetype to formatters
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        go = { "gofumpt", "goimports_reviser", "gofmt", "golines" }, -- "goimports", "gofmt"
        json = { "jq" },
        yaml = { "prettier" },
        -- Use a sub-list to run only the first available formatter
        javascript = { { "prettierd", "prettier" } },
        -- You can use a function here to determine the formatters dynamically
        python = function(bufnr)
          if require("conform").get_formatter_info("ruff_format", bufnr).available then
            return { "ruff_format" }
          else
            return { "autopep8", "isort", "black" }
          end
        end,
        sh = {
          "beautysh",
        },
        zsh = {
          "beautysh",
        },
        -- Use the "*" filetype to run formatters on all filetypes.
        ["*"] = { "codespell" },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = { "trim_whitespace" },
      },
      -- If this is set, Conform will run the formatter on save.
      -- It will pass the table to conform.format().
      -- This can also be a function that returns the table.
      format_on_save = {
        -- I recommend these options. See :help conform.format for details.
        lsp_fallback = false,
        timeout_ms = 500,
      },
      -- If this is set, Conform will run the formatter asynchronously after save.
      -- It will pass the table to conform.format().
      -- This can also be a function that returns the table.
      format_after_save = {
        lsp_fallback = false,
      },
      -- Set the log level. Use `:ConformInfo` to see the location of the log file.
      log_level = vim.log.levels.ERROR,
      -- Conform will notify you when a formatter errors
      notify_on_error = true,
      -- Custom formatters and changes to built-in formatters
      formatters = {},
    })
  end,
  keys = {
    { "<leader>cf", '<cmd>lua require("conform").format()<cr>', desc = "Format current file" },
  },
}
