local autocmd = vim.api.nvim_create_autocmd
local utils = require("utils")
local augroup = utils.create_augroup
local opt_local = vim.opt_local

vim.opt_local.cursorline = false
vim.opt_local.number = false -- Display line numbers in the focussed window only
vim.opt_local.relativenumber = false -- Display relative line numbers in the focussed window only
vim.opt_local.modifiable = true
vim.opt_local.cursorline = false -- Display a cursorline in the focussed window only
vim.opt_local.scrolloff = 0
vim.opt_local.buflisted = false
vim.opt_local.cursorcolumn = false
opt_local.signcolumn = "no"
opt_local.statuscolumn = ""

for _, key in ipairs({ "h", "j", "k", "l" }) do
  vim.keymap.set("t", "<C-" .. key .. ">", function()
    local code_term_esc = vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, true, true)
    local code_dir = vim.api.nvim_replace_termcodes("<C-" .. key .. ">", true, true, true)
    vim.api.nvim_feedkeys(code_term_esc .. code_dir, "t", true)
  end, { noremap = true })
end
if not vim.g.SessionLoad then
  vim.cmd.startinsert()
end
vim.cmd.startinsert()

vim.cmd([[tnoremap ,reload %load_ext autoreload<CR>%autoreload 2<CR>]])

-- For exiting the terminal mode. Better than the default config
-- vim.cmd([[
--  tnoremap <Esc> <C-\><C-n><CR>
-- ]])

-- @trial this (or move it to `term.lua`?)
-- This seems to properly remove the Terminal when closed. so KEEP IT!
local terminal = augroup("TerminalLocalOptions")
autocmd({ "TermClose" }, {
  group = terminal,
  pattern = { "*" },
  callback = function()
    --- automatically close a terminal if the job was successful
    -- if not vim.v.event.status == 0 then vim.cmd.bdelete({ fn.expand("<abuf>"), bang = true }) end
    if vim.v.event.status == 0 then
      vim.cmd.bdelete({ vim.fn.expand("<abuf>"), bang = true })
    end
  end,
})
