local dap = require("dap")
dap.adapters.go = function(callback, config)
  local stdout = vim.loop.new_pipe(false)
  local handle
  local pid_or_err
  local port = 38697
  local opts = {
    stdio = { nil, stdout },
    args = { "dap", "-l", "127.0.0.1:" .. port },
    detached = true,
  }
  handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
    stdout:close()
    handle:close()
    if code ~= 0 then
      print("dlv exited with code", code)
    end
  end)
  assert(handle, "Error running dlv: " .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)
  vim.defer_fn(function()
    callback({ type = "server", host = "127.0.0.1", port = port })
  end, 100)
end

-- dap.adapters.go = function(config)
--   config.adapters = function(callback, _)
--     local stdout = vim.loop.new_pipe(false)
--     local handle, pid_or_err
--     local port = 38697
--
--     handle, pid_or_err = vim.loop.spawn("dlv", {
--       stdio = { nil, stdout },
--       args = { "dap", "-l", "127.0.0.1:" .. port },
--       detached = true,
--     }, function(code)
--       stdout:close()
--       handle:close()
--
--       print("[delve] Exit Code:", code)
--     end)
--
--     assert(handle, "Error running dlv: " .. tostring(pid_or_err))
--
--     stdout:read_start(function(err, chunk)
--       assert(not err, err)
--
--       if chunk then
--         vim.schedule(function()
--           require("dap.repl").append(chunk)
--           print("[delve]", chunk)
--         end)
--       end
--     end)
--
--     -- Wait for delve to start
--     vim.defer_fn(function()
--       callback({ type = "server", host = "127.0.0.1", port = port })
--     end, 100)
--   end
-- end
dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
  {
    type = "go",
    name = "Debug test",
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  {
    type = "go",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
}
