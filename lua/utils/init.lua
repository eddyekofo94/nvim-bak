local M = {}
local fn = vim.fn

M.get_relative_fname = function()
  local fname = vim.fn.expand("%:p")
  return fname:gsub(vim.fn.getcwd() .. "/", "")
end

M.get_relative_gitpath = function()
  local fpath = vim.fn.expand("%:h")
  local fname = vim.fn.expand("%:t")
  local gitpath = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  local relative_gitpath = fpath:gsub(gitpath, "") .. "/" .. fname

  return relative_gitpath
end

M.toggle_quicklist = function()
  if fn.empty(fn.filter(fn.getwininfo(), "v:val.quickfix")) == 1 then
    vim.cmd("copen")
  else
    vim.cmd("cclose")
  end
end

return M
