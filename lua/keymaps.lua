-- Mapping helper
local mapper = require("utils").mapper
local set = require("utils").keymap_set
local utils_functions = require("utils.functions")

local Keymap = {}
Keymap.__index = Keymap
function Keymap.new(mode, lhs, rhs, opts)
  local action = function()
    local merged_opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
    vim.keymap.set(mode, lhs, rhs, merged_opts)
  end
  return setmetatable({ action = action }, Keymap)
end

function Keymap:bind(nextMapping)
  self.action()
  return nextMapping
end

function Keymap:execute()
  self.action()
end

local nxo = require("utils").nxo

vim.cmd("tnoremap <Esc> <C-\\><C-n><CR>")

mapper("n", "<Space>", "<NOP>")

-- Reconsider this option
-- Jump to start and end of line using the home row keys
set({ "n", "v" }, "H", "_")
set({ "n", "v" }, "L", "g_")

-- Easier line-wise movement
set(nxo, "gh", "g^")
set(nxo, "gl", "g$")

if vim.lsp.inlay_hint then
  set("n", "<leader>?", function()
    vim.lsp.inlay_hint(0, nil)
  end, { desc = "Toggle Inlay Hints" })
end

-- Show treesitter nodes under cursor
-- highlights under cursor
set("n", "<Leader>ui", vim.show_pos, { desc = "Show Treesitter Node" })

-- COPY EVERYTHING/ALL
mapper("n", "<C-a>", ": %y+<CR>")
-- SAVE
mapper("n", "<C-s>", ":w!<CR>")

--  REFC: 2023-11-15 11:56 AM - Bring this back maybe?
--  set(nxo, "p", "p=`]", { desc = "Paste should match indentation" })
--  set("v", "y", "may`a", { desc = "Restore cursor position after yank" })
set("n", "i", function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true, desc = "rebind 'i' to do a smart-indent if its a blank line" })

set("n", "dd", function()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return '"_dd'
  else
    return "dd"
  end
end, { expr = true, desc = "Don't yank empty lines into the main register" })

-- don't yank on paste
mapper("x", "p", '"_dP')

-- better up/down
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Don't know what this is doing exactly!
set("x", "v", "$h")

-- buffers
set("n", "[b", "<cmd>bprev<cr>", { desc = "Prev buffer" })
set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

set("n", "<TAB>", "<cmd>bnext<cr>", { desc = "Next buffer" })
set("n", "<S-TAB>", "<cmd>bprev<cr>", { desc = "Prev buffer" })

mapper("n", "<S-x>", [[<Cmd>bdelete!<CR>]]) -- close all other buffers but this one

set("v", "/", '"fy/\\V<C-R>f<CR>')
set("v", "*", '"fy/\\V<C-R>f<CR>')

set("v", "<c-r>w", ":%s/<c-r><c-w>//g<left><left>")

-- move over a closing element in insert mode
set("i", "<C-l>", function()
  return utils_functions.escapePair()
end, { desc = "move over a closing element in insert mode" })

-- Search always center
Keymap.new("n", "<C-u>", "zz<C-u>")
  :bind(Keymap.new("n", "<C-d>", "zz<C-d>"))
  :bind(Keymap.new("n", "{", "zz{"))
  :bind(Keymap.new("n", "}", "zz}"))
  :bind(Keymap.new("n", "n", "nzz"))
  :bind(Keymap.new("n", "N", "zzN"))
  :bind(Keymap.new("n", "<C-i>", "zz<C-i>"))
  :bind(Keymap.new("n", "<C-o>", "zz<C-o>"))
  :bind(Keymap.new("n", "%", "zz%"))
  :bind(Keymap.new("n", "*", "zz*"))
  :bind(Keymap.new("n", "#", "zz#"))
  :execute()

-- better window movement
Keymap.new("n", "<C-h>", "<C-w>h")
  :bind(Keymap.new("n", "<C-j>", "<C-w>j"))
  :bind(Keymap.new("n", "<C-k>", "<C-w>k"))
  :bind(Keymap.new("n", "<C-l>", "<C-w>l"))
  :execute()

-- " HARD MODE - Disabled arrows
Keymap.new("n", "<Up>", "<Nop>")
  :bind(Keymap.new("n", "<Down>", "<Nop>"))
  :bind(Keymap.new("n", "<Left>", "<Nop>"))
  :bind(Keymap.new("n", "<Right>", "<Nop>"))
  :bind(Keymap.new("i", "<right>", "<nop>"))
  :bind(Keymap.new("i", "<up>", "<nop>"))
  :bind(Keymap.new("i", "<down>", "<nop>"))
  :bind(Keymap.new("i", "<left>", "<nop>"))
  :execute()

-- " Move selected line / block of text in visual mode
-- " shift + k to move up
-- " shift + j to move down
mapper("x", "K", ":move '<-2<CR>gv-gv")
mapper("x", "J", ":move '>+1<CR>gv-gv")

-- better indenting
mapper("v", "<", "<gv")
mapper("v", ">", ">gv")

-- CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
mapper("i", "<C-c>", "<esc>")

mapper("n", "<M-CR>", ":let v:hlsearch=!v:hlsearch<CR>")

-- " Change the current word in insertmode.
-- "   Auto places you into the spot where you can start typing to change it.
mapper("n", "<c-r>w", ":%s/<c-r><c-w>//g<left><left>")

-- I hate escape
mapper("i", "jj", "<ESC>")

-- Very magic by default, got this from thePrimragen (Don't know exactly what it
--- does)
-- vim.cmd("nnoremap ? ?\v")
-- vim.cmd("nnoremap / /\v")
-- vim.cmd("cnoremap %s/  %sm/")

-- Move selected line / block of text in visual mode
mapper("x", "K", ":move '<-2<CR>gv-gv")
mapper("x", "J", ":move '>+1<CR>gv-gv")

-- Diffview
mapper("n", "<leader>gD", "<cmd>DiffviewOpen --untracked-files=no<CR>")
mapper("n", "<leader>gH", "<cmd>DiffviewFileHistory %<CR>")

-- Whatever you delete, make it go away
set({ "n", "x" }, "c", '"_c')
set(nxo, "%", "gg0vG$")
set({ "n", "x" }, "C", '"_C')
set({ "n", "x" }, "S", '"_S', "Don't save to register")

set({ "n", "x" }, "x", '"_x')
set("x", "X", '"_c')

return mapper
