return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  -- enabled = false,
  config = function()
    -- code
    require("conform").setup({
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },
      format_after_save = {
        lsp_fallback = true,
      },
      log_level = vim.log.levels.ERROR,
      notify_on_error = true,
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will use the first available formatter in the list
        javascript = { "prettier_d", "prettier" },
        -- Formatters can also be specified with additional options
        python = {
          formatters = { "autopep8", "isort", "black" },
          -- Run formatters one after another instead of stopping at the first success
          run_all_formatters = true,
        },
        go = {
          formatters = { "gofumpt", "goimports", "golines" },
          go = { "goimports_reviser", "gofmt", "golines" },
          run_all_formatters = true,
        },
        json = {
          formatters = { "jq" },
        },
        sh = {
          "beautysh",
        },
        ["*"] = { "trim_whitespace" },
      },
    })
  end,
  keys = {
    { "<leader>cf", '<cmd>lua require("conform").format()<cr>', desc = "Format current file" },
  },
}
-- return {
--     "mhartington/formatter.nvim",
--     event = "VeryLazy",
--     --cmd = "Format",
--     config = function()
--         -- Utilities for creating configurations
--         local util = require("formatter.util")
--
--         -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
--         require("formatter").setup({
--             format_on_save = {
--                 lsp_fallback = true,
--                 timeout_ms = 500,
--             },
--             format_after_save = {
--                 lsp_fallback = true,
--             },
--             notify_on_error = true,
--             -- Enable or disable logging
--             logging = true,
--             -- Set the log level
--             log_level = vim.log.levels.WARN,
--             -- All formatter configurations are opt-in
--             filetype = {
--                 -- Formatter configurations for filetype "lua" go here
--                 -- and will be executed in order
--                 lua = {
--                     -- "formatter.filetypes.lua" defines default configurations for the
--                     -- "lua" filetype
--                     require("formatter.filetypes.lua").stylua,
--
--                     -- You can also define your own configuration
--                     function()
--                         -- Supports conditional formatting
--                         if util.get_current_buffer_file_name() == "special.lua" then
--                             return nil
--                         end
--
--                         -- Full specification of configurations is down below and in Vim help
--                         -- files
--                         return {
--                             exe = "stylua",
--                             args = {
--                                 "--search-parent-directories",
--                                 "--stdin-filepath",
--                                 util.escape_path(util.get_current_buffer_file_path()),
--                                 "--",
--                                 "-",
--                             },
--                             stdin = true,
--                         }
--                     end,
--                 },
--                 go = {
--                     formatters = { 'gofumpt', 'goimports', 'golines' },
--                     run_all_formatters = true,
--                 },
--                 json = {
--                     formatters = { 'jq' },
--                 },
--                 python = {
--                     require("formatter.filetypes.python").autopep8,
--                 },
--                 sh = {
--                     require("formatter.filetypes.sh").shfmt,
--                 },
--                 -- Use the special "*" filetype for defining formatter configurations on
--                 -- any filetype
--                 ["*"] = {
--                     -- "formatter.filetypes.any" defines default configurations for any
--                     -- filetype
--                     require("formatter.filetypes.any").remove_trailing_whitespace,
--                 },
--             },
--         })
--     end,
-- }
