---------
-- Git --
---------
vim.opt.fillchars = { diff = " " }

return {
  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    keys = {
      {
        "<leader>gs",
        "<cmd>Neogit status<CR>",
        desc = "Git status",
      },
      "<leader>gC",
      {
        "<leader>gd",
        "<cmd>Neogit diff<CR>",
        desc = "Git diff",
      },
      { "<leader>gcc", "<cmd>Neogit commit<CR>", desc = "Git commit" },
      { "<leader>gp", "<cmd>Neogit pull<CR>", desc = "Git pull" },
      { "<leader>gP", "<cmd>Neogit push<CR>", desc = "Git push" },
      { "<leader>gr", "<cmd>Neogit rebase<CR>", desc = "Git rebase" },
      { "<leader>gl", "<cmd>Neogit log<CR>", desc = "Git log" },
    },
    config = function()
      local map = require("utils").map
      local cmd, call = vim.cmd, vim.call

      local neogit = require("neogit")
      neogit.setup({
        commit_popup = {
          kind = "auto",
        },
        signs = {
          section = { "", "" },
          item = { "", "" },
        },
        integrations = { diffview = true },
        disable_builtin_notifications = true,
        disable_commit_confirmation = true,
      })

      map("n", "<leader>gco", require("telescope.builtin").git_branches, "Git checkout")
      map("n", "<leader>gss", function()
        neogit.open({
          cwd = vim.fn.expand("%:p:h"),
          kind = "auto",
        })
      end, "Neogit status")

      local group = vim.api.nvim_create_augroup("MyCustomNeogitEvents", { clear = true })
      -- giving me an error
      vim.api.nvim_create_autocmd("User", {
        pattern = "NeogitPushComplete",
        group = group,
        callback = require("neogit").close,
      })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
  },
}
