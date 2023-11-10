local utils = require("utils")
local opt_local = vim.opt_local
local contains = vim.tbl_contains
local keymap_set = require("utils").keymap_set

local autocmd = vim.api.nvim_create_autocmd
local augroup = utils.create_augroup

-- General Settings
local general = augroup("General Settings")

local ignore_filetypes = { "neo-tree" }
local ignore_buftypes = { "nofile", "prompt", "popup" }
local file_pattern = {
  "*.py",
  "*.zsh",
  ".zshrc",
  ".zprofile",
  ".zshenv",
  "*.yaml",
  "*.css",
  "*.fish",
  "*.html",
  "*.json",
  "*.lua",
  "*.go",
  "*.md",
  "*.rb",
  "*.sh",
  "*.vim",
  "*.ts",
  "Dockerfile",
  "*.cpp",
}

-- Check if we need to reload the file when it changed
autocmd({ "BufWinEnter", "BufWinLeave", "BufRead", "BufEnter", "FocusGained" }, { command = "silent! checktime" })

autocmd("FileType", {
  pattern = { "go", "c", "cpp", "py", "java", "cs" },
  callback = function()
    vim.bo.shiftwidth = 4
  end,
  group = general,
  desc = "Set shiftwidth to 4 in these filetypes",
})

-- Remove trailing whitespace on save!
autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function(ev)
    local save_cursor
    save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

local cursor_line = augroup("LocalCursorLine")
autocmd({ "BufEnter", "WinEnter", "BufWinEnter" }, {
  group = cursor_line,
  pattern = file_pattern,
  callback = function()
    opt_local.cursorline = true
    opt_local.number = true -- Display line numbers in the focussed window only
    opt_local.relativenumber = true -- Display relative line numbers in the focussed window only
    opt_local.cursorline = true -- Display a cursorline in the focussed window only
    opt_local.cursorcolumn = true
    require("utils.hjkl_notifier")
    -- opt_local.winbar = true
  end,
})

autocmd({ "BufLeave", "BufWinLeave" }, {
  group = cursor_line,
  pattern = file_pattern,
  callback = function()
    opt_local.cursorline = false
    opt_local.number = false -- Display line numbers in the focussed window only
    opt_local.relativenumber = false -- Display relative line numbers in the focussed window only
    opt_local.cursorline = false -- Display a cursorline in the focussed window only
    opt_local.cursorcolumn = false
  end,
})

-- Enable spell checking for certain file types
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.txt", "*.md", "*.tex" },
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = "en"
  end,
})

-- NOTE: should restore cursor position on the last one
autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
local smart_close_filetypes = {
  "qf",
  "help",
  "oil",
  "undotree",
  "man",
  "NeogitStatus",
  "notify",
  "term",
  "lspinfo",
  "spectre_panel",
  "startuptime",
  "tsplayground",
  "PlenaryTestPopup",
}

local smart_close_buftypes = {}
local function smart_close()
  if vim.fn.winnr("$") ~= 1 then
    vim.api.nvim_win_close(0, true)
    vim.cmd("wincmd p")
  end
end

-- Close certain filetypes by pressing q.
autocmd("FileType", {
  pattern = { "*" },
  callback = function()
    local is_unmapped = vim.fn.hasmapto("q", "n") == 0
    local is_eligible = is_unmapped
      or vim.wo.previewwindow
      or contains(smart_close_buftypes, vim.bo.buftype)
      or contains(smart_close_filetypes, vim.bo.filetype)
    if is_eligible then
      keymap_set("n", "q", smart_close, { buffer = 0, nowait = true })
    end
  end,
})

local au = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

autocmd("WinEnter", {
  group = au,
  callback = function(_)
    if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
      vim.w.focus_disable = true
    else
      vim.w.focus_disable = false
    end
  end,
  desc = "Disable focus autoresize for BufType",
})

-- local terminal = augroup("TerminalLocalOptions")
-- autocmd({ "TermOpen" }, {
--   group = terminal,
--   pattern = { "*" },
--   callback = function(event)
--     opt_local.number = false
--     opt_local.relativenumber = false
--     opt_local.cursorline = false
--     opt_local.signcolumn = "no"
--     opt_local.statuscolumn = ""
--     opt_local.buflisted = false
--     for _, key in ipairs({ "h", "j", "k", "l" }) do
--       vim.keymap.set("t", "<C-" .. key .. ">", function()
--         local code_term_esc = vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, true, true)
--         local code_dir = vim.api.nvim_replace_termcodes("<C-" .. key .. ">", true, true, true)
--         vim.api.nvim_feedkeys(code_term_esc .. code_dir, "t", true)
--       end, { noremap = true })
--     end
--     if not vim.g.SessionLoad then
--       vim.cmd(":startinsert")
--     end
--     if vim.bo.filetype == "" then
--       vim.api.nvim_buf_set_option(event.buf, "filetype", "term")
--       vim.cmd.startinsert()
--     end
--   end,
-- })

autocmd("FileType", {
  group = general,
  callback = function(_)
    if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
      vim.w.focus_disable = true
    else
      vim.w.focus_disable = false
    end
  end,
  desc = "Disable focus autoresize for FileType",
})

-- use bash-treesitter-parser for zsh
local zsh_as_bash = augroup("zshAsBash")
autocmd("BufWinEnter", {
  group = zsh_as_bash,
  pattern = { ".zprofile", "*.zsh", ".zshenv", ".zshrc" },
  command = "silent! set filetype=sh",
})

-- Center the buffer after search in cmd mode
autocmd("CmdLineLeave", {
  callback = function()
    vim.api.nvim_feedkeys("zz", "n", false)
  end,
})
-- autosave file when buffer leave or focus lost
-- vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost' }, {
--     callback = function()
--         if
--             vim.bo.modified
--             and not vim.bo.readonly
--             and vim.fn.expand('%') ~= ''
--             and vim.bo.buftype == ''
--         then
--             vim.api.nvim_command('silent update')
--         end
--     end,
-- })

-- Delete [No Name] buffers
-- autocmd("BufHidden", {
--     callback = function(event)
--         if event.file == "" and vim.bo[event.buf].buftype == "" and not vim.bo[event.buf].modified then
--             vim.schedule(function() pcall(vim.api.nvim_buf_delete, event.buf, {}) end)
--         end
--     end,
-- })

utils.define_augroups({
  _general_settings = {
    { "BufWinEnter", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
    { "BufRead", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
    { "BufNewFile", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
    { "VimLeavePre", "*", "set title set titleold=" },
  },
  _dashboard = {
    {
      "FileType",
      "dashboard",
      "setlocal nocursorline noswapfile synmaxcol& signcolumn=no norelativenumber nocursorcolumn nospell  nolist  nonumber bufhidden=wipe colorcolumn= foldcolumn=0 matchpairs= ",
    },
    { "FileType", "dashboard", "set showtabline=0 | autocmd BufLeave <buffer> set showtabline=2" },
  },
  _markdown = { { "FileType", "markdown", "setlocal wrap" }, { "FileType", "markdown", "setlocal spell" } },
  _buffer_bindings = {
    { "FileType", "dashboard", "nnoremap <silent> <buffer> q :q<CR>" },
    { "FileType", "NeogitStatus", "nnoremap <silent> <buffer> q :q<CR>" },
    { "FileType", "lspinfo", "nnoremap <silent> <buffer> q :q<CR>" },
    { "FileType", "qf", "nnoremap <silent> <buffer> q :q<CR>" },
  },
  _telescope = { { "User", "TelescopePreviewerLoaded", ":setlocal wrap" } },
})
