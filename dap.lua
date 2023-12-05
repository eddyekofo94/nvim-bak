return {
  "rcarriga/nvim-dap-ui",
  event = "VeryLazy",
  dependencies = {
    "theHamsta/nvim-dap-virtual-text",
    "nvim-telescope/telescope-dap.nvim",
    -- "jay-babu/mason-nvim-dap.nvim",
    "nvim-telescope/telescope-dap.nvim",
    "leoluz/nvim-dap-go",
    "mfussenegger/nvim-dap-python",
    "jbyuki/one-small-step-for-vimkind",
    "mfussenegger/nvim-dap",
    "Weissle/persistent-breakpoints.nvim",
  },
  config = function()
    local keymap = require("utils").keymap_set
    require("dapui").setup()
    local dap = require("dap")

    -- require("mason-nvim-dap").setup({
    --   ensure_installed = { "python", "delve" },
    --   handlers = {
    --     function(config)
    --       require("mason-nvim-dap").default_setup(config)
    --     end,
    --   },
    -- })

    require("persistent-breakpoints").setup({
      load_breakpoints_event = { "BufReadPost" },
    })

    require("nvim-dap-virtual-text").setup({})

    vim.fn.sign_define(
      "DapBreakpoint",
      { text = "🔴", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
    vim.fn.sign_define("DapStopped", { text = "▶", texthl = "Green", linehl = "ColorColumn", numhl = "Green" })

    keymap("n", "<Leader>xx", function()
      require("dap").continue()
    end, "dap continue")
    keymap("n", "<Leader>xb", function()
      require("persistent-breakpoints.api").toggle_breakpoint()
    end, "pb toggle breakpoint")
    keymap("n", "<leader>xcb", function()
      require("persistent-breakpoints.api").set_conditional_breakpoint()
    end, "pb conditional breakpoint")
    keymap("n", "<leader>xB", function()
      require("persistent-breakpoints.api").clear_all_breakpoints()
    end, "clear all breakpoints")
    keymap("n", "<Leader>xh", function()
      require("dapui").eval()
    end, "dap eval")
    keymap("n", "<Leader>xi", function()
      require("dap").step_into()
    end, "dap setp into")
    keymap("n", "<Leader>xo", function()
      require("dap").step_out()
    end, "dap step out")
    keymap("n", "<Leader>xO", function()
      require("dap").step_over()
    end, "dap step over")
    keymap("n", "<Leader>xt", function()
      require("dap").terminate()
    end, "terminate")
    keymap("n", "<Leader>xu", function()
      require("dapui").toggle()
    end, "dap toggle")
    keymap("n", "<Leader>xC", function()
      -- code
      require("dapui").close()
    end, "dap close")
    keymap("n", "<Leader>xr", function()
      require("dapui").float_element("repl", { enter = true })
    end, "dap float element")

    keymap("n", "<Leader>xw", function()
      require("dapui").float_element("watches", { enter = true })
    end, "dap float watches")

    keymap("n", "<Leader>xs", function()
      require("dapui").float_element("scopes", { enter = true })
    end, "dap float scopes")
  end,
}
