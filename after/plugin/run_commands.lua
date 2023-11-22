local build_commands = {
  c = "g++ -std=c++17 -o %:p:r.o %",
  cpp = "g++ -std=c++17 -Wall -O2 -o %:p:r.o %",
  rust = "cargo build --release",
  go = "go build -o %:p:r.o %",
}

local debug_build_commands = {
  c = "g++ -std=c++17 -g -o %:p:r.o %",
  cpp = "g++ -std=c++17 -g -o %:p:r.o %",
  rust = "cargo build",
  go = "go build -o %:p:r.o %",
}

local run_commands = {
  c = "%:p:r.o",
  cpp = "%:p:r.o",
  rust = "cargo run --release",
  go = "%:p:r.o",
  -- sh = "" TODO: make a shell related files run
}

vim.api.nvim_create_user_command("Build", function()
  local filetype = vim.bo.filetype

  for file, command in pairs(build_commands) do
    if filetype == file then
      print("Building: " .. file)
      vim.cmd("!" .. command)
      break
    end
  end
end, {})

vim.api.nvim_create_user_command("DebugBuild", function()
  local filetype = vim.bo.filetype

  for file, command in pairs(debug_build_commands) do
    if filetype == file then
      vim.cmd("!" .. command)
      break
    end
  end
end, {})

vim.api.nvim_create_user_command("Run", function()
  local filetype = vim.bo.filetype

  for file, command in pairs(run_commands) do
    if filetype == file then
      print("Running: " .. file)
      vim.cmd("sp")
      vim.cmd("term " .. command)
      vim.cmd("resize 20N")
      local keys = vim.api.nvim_replace_termcodes("i", true, false, true)
      vim.api.nvim_feedkeys(keys, "n", false)
      break
    end
  end
end, {})

vim.api.nvim_create_user_command("RunAll", function()
  local filetype = vim.bo.filetype
  print("Building & Running: " .. filetype)
  vim.cmd([[Build]])
  vim.cmd([[Run]])
end, {})

vim.api.nvim_create_user_command("Config", function()
  vim.cmd([[cd ~/.config/nvim]])
end, {})
