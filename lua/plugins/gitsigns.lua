return {
  -- git signs
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local signs = require("gitsigns")
    signs.setup({
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = require("utils").keymap_set

        -- Navigation
        -- map('n', ']c', function()
        --     if vim.wo.diff then return ']c' end
        --     vim.schedule(function() gs.next_hunk() end)
        --     return '<Ignore>'
        -- end, { expr = true })
        --
        -- map('n', '[c', function()
        --     if vim.wo.diff then return '[c' end
        --     vim.schedule(function() gs.prev_hunk() end)
        --     return '<Ignore>'
        -- end, { expr = true })

        map({ "n", "v" }, "<leader>gg", "<cmd>Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>gx", "<cmd>Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>gG", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>gX", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>", "toggle blame line")
        map("n", "<leader>gv", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, "Blame Line")
        map("n", "<leader>gd", gs.diffthis, "Diff This")
        map("n", "<leader>gD", function()
          gs.diffthis("~")
        end, "Diff This ~")
        map({ "o", "x" }, "ih", "<cmd>C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
      signs = {
        add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr" },
        change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr" },
        delete = { hl = "GitSignsDelete", text = "│ ", numhl = "GitSignsDeleteNr" },
        topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr" },
        changedelete = { hl = "GitSignsDelete", text = "│", numhl = "GitSignsChangeNr" },
      },

      -- Highlights just the number part of the number column
      numhl = false,

      -- Highlights the _whole_ line.
      --    Instead, use gitsigns.toggle_linehl()
      linehl = false,

      -- Highlights just the part of the line that has changed
      --    Instead, use gitsigns.toggle_word_diff()
      word_diff = false,

      current_line_blame_formatter = " <author>:<author_time:%Y-%m-%d> - <summary>",

      current_line_blame_opts = {
        delay = 1000,
        virt_text_pos = "eol",
      },
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      preview_config = {
        border = "single",
        style = "minimal",
      },
      signcolumn = true, -- INFO: come back to this if you're not happy with the numberhl
      sign_priority = 6,
      update_debounce = 200,
      status_formatter = nil, -- Use default
    })
  end,
}
