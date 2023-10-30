------------------
-- Git conflict --
------------------
return {
  "akinsho/git-conflict.nvim",
  version = "*", -- `main` is unstable
  event = "VeryLazy",
  config = function()
    local map = require("utils").keymap_set

    require("git-conflict").setup({
      default_mappings = false,
      disable_diagnostics = true,
    })

    -- vim.api.nvim_create_autocommand("User", {
    --   pattern = "GitConflictDetected",
    --   callback = function()
    --     vim.notify("Conflict detected in " .. vim.fn.expand("<afile>"))
    --     vim.keymap.set("n", "cww", function()
    --       engage.conflict_buster()
    --       create_buffer_local_mappings()
    --     end)
    --   end,
    -- })

    map("n", "gc<", "<Plug>(git-conflict-ours)", "Git conflict take ours")
    map("n", "gc>", "<Plug>(git-conflict-theirs)", "Git conflict take theirs")
    map("n", "gcb", "<Plug>(git-conflict-both)", "Git conflict take both")
    map("n", "gc0", "<Plug>(git-conflict-none)", "Git conflict take none")
    map("n", "]c", "<Plug>(git-conflict-next-conflict)", "Next conflict")
    map("n", "[c", "<Plug>(git-conflict-prev-conflict)", "Previous conflict")
  end,
}
