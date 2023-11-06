return {
  "rcarriga/nvim-dap-ui",
  event = "VeryLazy",
  dependencies = {
    "theHamsta/nvim-dap-virtual-text",
    "nvim-telescope/telescope-dap.nvim",
    --  Adaparter configuration for specific languages
    { "leoluz/nvim-dap-go" },
    { "mfussenegger/nvim-dap-python" },
    "jbyuki/one-small-step-for-vimkind",
    "mfussenegger/nvim-dap",
  },
  init = function()
    require("dapui").setup()
    local dap = require("dap")

    dap.adapters.cpp = {
      type = "executable",
      attach = {
        pidProperty = "pid",
        pidSelect = "ask",
      },
      command = "lldb-vscode", -- my binary was called 'lldb-vscode-11'
      env = {
        LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
      },
      name = "lldb",
    }

    --  https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
    dap.adapters.go = function(callback, _)
      local stdout = vim.loop.new_pipe(false)
      local handle, pid_or_err
      local port = 38697

      handle, pid_or_err = vim.loop.spawn("dlv", {
        stdio = { nil, stdout },
        args = { "dap", "-l", "127.0.0.1:" .. port },
        detached = true,
      }, function(code)
        stdout:close()
        handle:close()

        print("[delve] Exit Code:", code)
      end)

      assert(handle, "Error running dlv: " .. tostring(pid_or_err))

      stdout:read_start(function(err, chunk)
        assert(not err, err)

        if chunk then
          vim.schedule(function()
            require("dap.repl").append(chunk)
            print("[delve]", chunk)
          end)
        end
      end)

      -- Wait for delve to start
      vim.defer_fn(function()
        callback({ type = "server", host = "127.0.0.1", port = port })
      end, 100)
    end

    dap.configurations.go = {
      {
        type = "go",
        name = "Debug (from vscode-go)",
        request = "launch",
        showLog = false,
        program = "${file}",
        dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
      },
      {
        type = "go",
        name = "Debug (No File)",
        request = "launch",
        program = "",
      },
      {
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${file}",
        showLog = true,
        -- console = "externalTerminal",
        -- dlvToolPath = vim.fn.exepath "dlv",
      },
      {
        name = "Test Current File",
        type = "go",
        request = "launch",
        showLog = true,
        mode = "test",
        program = ".",
        dlvToolPath = vim.fn.exepath("dlv"),
      },
    }
  end,
}
