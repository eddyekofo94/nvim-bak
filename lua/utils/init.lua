local M = {}
local fn = vim.fn
M.log = function(message, title)
  require("notify")(message, "info", { title = title or "Info" })
end

M.warnlog = function(message, title)
  require("notify")(message, "warn", { title = title or "Warning" })
end

M.errorlog = function(message, title)
  require("notify")(message, "error", { title = title or "Error" })
end

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

M.closeOtherBuffers = function()
  for _, e in ipairs(require("bufferline").get_elements().elements) do
    vim.schedule(function()
      if e.id == vim.api.nvim_get_current_buf() then
        return
      elseif pcall(require, "mini.bufremove") then
        require("mini.bufremove").delete(e.id, false)
      else
        vim.cmd("bd " .. e.id)
      end
    end)
  end
end

return M
