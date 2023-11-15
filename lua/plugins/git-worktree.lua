return {
  "ThePrimeagen/git-worktree.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local worktree = require("git-worktree")
    local utils = require("utils")
    local keymap_set = utils.keymap_set

    worktree.setup({
      change_directory_command = "cd", -- default: "cd",
      update_on_change = true, -- default: true,
      update_on_change_command = "e .", -- default: "e .",
      clearjumps_on_change = true, -- default: true,
      autopush = false, -- default: false,
    })

    require("telescope").load_extension("git_worktree")

    keymap_set("n", "<leader>gwc", function()
      require("telescope").extensions.git_worktree.create_git_worktree()
    end, "Git Worktree create")

    keymap_set("n", "<Leader>gww", function()
      require("telescope").extensions.git_worktree.git_worktrees()
    end, "Git worktree list")

    worktree.on_tree_change(function(op, metadata)
      if op == worktree.Operations.Switch then
        utils.log("Switched from " .. metadata.prev_path .. " to " .. metadata.path, "Git Worktree")
        utils.closeOtherBuffers()
        vim.cmd("e")
      end
    end)
  end,
}
