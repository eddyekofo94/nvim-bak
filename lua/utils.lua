local M = {}
-- local mapper = require("keymaps").mapper
M.nxo = { "n", "x", "o" } -- normal, visual, operator (for motion mappings)

M.termcodes = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.map = function(modes, lhs, rhs, opts)
  if type(opts) == "string" then
    opts = { desc = opts }
  end
  vim.keymap.set(modes, lhs, rhs, opts)
end

M.nmap = function(tbl)
  if type(tbl[3]) == "string" then
    tbl[3] = { desc = tbl[3] }
  end
  vim.keymap.set("n", tbl[1], tbl[2], tbl[3])
end

function M.is_buffer_empty()
  -- Check whether the current buffer is empty
  return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

function M.has_width_gt(cols)
  -- Check if the windows width is greater than a given number of columns
  return vim.fn.winwidth(0) / 2 > cols
end

M.root_patterns = { ".git", "lua" }

function M.auto_format()
  local client = vim.lsp.get_clients()[1]
  local filetype = vim.api.nvim_get_option_value("filetype")

  -- Set some keybinds conditional on server capabilities
  if client.supports_method("textDocument/formatting") then
    print("Using Lsp Format")
    M.lsp_autocmd("BufWritePre", ":lua vim.lsp.buf.format()")
  elseif client.supports_method("textDocument/rangeFormatting") then
    print("Using Lsp Range Format")
    M.lsp_autocmd("BufWritePre", "<cmd>lua vim.lsp.buf.range_formatting()")
  elseif vim.tbl_contains({ "go", "rust" }, filetype) then
    print("Using Lsp Go/Rust Format")
    vim.cmd([[autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()]])
  else
    print("Using Formatter")
    M.lsp_autocmd("BufWritePre", ":Format")
  end
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace
          and vim.tbl_map(function(ws)
            return vim.uri_to_fname(ws.uri)
          end, workspace)
        or client.config.root_dir and { client.config.root_dir }
        or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)

  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
end

-- this will return a function that calls telescope.
-- cwd will default to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
function M.telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend("force", { cwd = M.get_root() }, opts or {})
    if builtin == "files" then
      if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
        opts.show_untracked = true
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    require("telescope.builtin")[builtin](opts)
  end
end

local function lsp_server_has_references()
  for _, client in pairs(vim.lsp.get_clients()) do
    if client.server_capabilities then
      return true
    end
  end
  return false
end

function M.lsp_autocmd(type, command)
  -- code
  vim.api.nvim_create_autocmd(type, {
    callback = function()
      if not lsp_server_has_references then
        return
      end
      vim.api.nvim_exec(command, false)
    end,
  })
end

--- Gets the buffer number of every visible buffer
--- @return integer[]
M.visible_buffers = function()
  return vim.tbl_map(vim.api.nvim_win_get_buf, vim.api.nvim_list_wins())
end

function M.define_augroups(definitions) -- {{{1
  -- Create autocommand groups based on the passed definitions
  --
  -- The key will be the name of the group, and each definition
  -- within the group should have:
  --    1. Trigger
  --    2. Pattern
  --    3. Text
  -- just like how they would normally be defined from Vim itself
  for group_name, definition in pairs(definitions) do
    vim.cmd("augroup " .. group_name)
    vim.cmd("autocmd!")

    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
      vim.cmd(command)
    end

    vim.cmd("augroup END")
  end
end

-- Mapping helper
function M.mapper(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, { noremap = true, silent = true })
end

M.feedkeys = function(keys, mode)
  if mode == nil then
    mode = "in"
  end
  return vim.api.nvim_feedkeys(M.termcodes(keys), mode, true)
end

function M.keymap_set(modes, lhs, rhs, opts)
  if type(opts) == "string" then
    opts = { desc = opts }
  end
  vim.keymap.set(modes, lhs, rhs, opts)
end

-- TODO: try yo get this fixed
local enabled = true
function M.toggle_diagnostics()
  enabled = not enabled
  if enabled then
    vim.diagnostic.enable()
    Util.info("Enabled diagnostics", { title = "Diagnostics" })
  else
    vim.diagnostic.disable()
    Util.warn("Disabled diagnostics", { title = "Diagnostics" })
  end
end

M.map_q_to_quit = function(event)
  vim.bo[event.buf].buflisted = false
  M.cmd_map("q", "close", "n", { silent = true, noremap = true, buffer = true })
end

M.create_augroup = function(group, opts)
  opts = opts or { clear = true }
  return vim.api.nvim_create_augroup(group, opts)
end

local function get_bufs_loaded()
  local bufs_loaded = {}

  for i, buf_hndl in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf_hndl) then
      bufs_loaded[i] = buf_hndl
    end
  end

  return bufs_loaded
end

--  BUG: 2023-11-24 13:23 PM - Not removing
--  folders accurately
M.closeOtherBuffers = function()
  for _, buffer in ipairs(get_bufs_loaded()) do
    vim.schedule(function()
      if buffer == vim.api.nvim_get_current_buf() then
        return
      elseif pcall(require, "mini.bufremove") then
        require("mini.bufremove").delete(buffer, false)
      else
        vim.cmd("bd " .. buffer)
      end
    end)
  end
end

M.log = function(message, title)
  require("notify")(message, "info", { title = title or "Info" })
end

M.warnlog = function(message, title)
  require("notify")(message, "warn", { title = title or "Warning" })
end

M.errorlog = function(message, title)
  require("notify")(message, "error", { title = title or "Error" })
end

return M
