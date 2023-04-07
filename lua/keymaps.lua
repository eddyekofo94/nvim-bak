-- Mapping helper
local mapper = require("utils").mapper
local set = require("utils").set

vim.g.mapleader = " "
local nxo = { "n", "x", "o" } -- normal, visual, operator (for motion mappings)

mapper("n", "<Space>", "<NOP>")

-- Reconsider this option
-- Jump to start and end of line using the home row keys
mapper("n", "H", "^")
mapper("n", "L", "$")

-- COPY EVERYTHING/ALL
mapper("n", "<C-a>", ": %y+<CR>")
-- SAVE
mapper("n", "<C-s>", ":w!<CR>")

-- don't yank on paste
mapper("x", "p", '"_dP')

-- better up/down
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- buffers
set("n", "[b", "<cmd>bprev<cr>", { desc = "Prev buffer" })
set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
set("n", "<c-p>", "<cmd>bprev<cr>", { desc = "Prev buffer" })
set("n", "<c-n>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- cycle through command history without arrow keys
mapper("c", "<c-j>", "<down>")
mapper("c", "<c-k>", "<up>")

mapper("n", "gd", "<cmd>Lspsaga lsp_finder<CR>")
mapper("n", "K", "<cmd>Lspsaga hover_doc<CR>")

-- Search always center
mapper("n", "n", "nzzzv")
mapper("n", "N", "Nzzzv")
mapper("n", "{", "{zzzv")
mapper("n", "}", "}zzzv")
mapper("n", "<C-d>", "<C-d>zzzv")
mapper("n", "<C-u>", "<C-u>zzzv")

-- explorer
mapper("n", "<Leader>e", ":Neotree source=filesystem reveal=true position=right toggle=true<CR>")

-- better window movement
mapper("n", "<C-h>", "<C-w>h")
mapper("n", "<C-j>", "<C-w>j")
mapper("n", "<C-k>", "<C-w>k")
mapper("n", "<C-l>", "<C-w>l")

-- " HARD MODE - Disabled arrows
mapper("n", "<Up>", "<Nop>")
mapper("n", "<Down>", "<Nop>")
mapper("n", "<Left>", "<Nop>")
mapper("n", "<Right>", "<Nop>")

mapper("i", "<up>", "<nop>")
mapper("i", "<down>", "<nop>")
mapper("i", "<left>", "<nop>")
mapper("i", "<right>", "<nop>")
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
mapper("i", "jk", "<ESC>")
mapper("i", "kj", "<ESC>")
mapper("i", "jj", "<ESC>")

-- Very magic by default, got this from thePrimragen (Don't know exactly what it
--- does
-- vim.cmd("nnoremap ? ?\v")
-- vim.cmd("nnoremap / /\v")
-- vim.cmd("cnoremap %s/  %sm/")

-- Move selected line / block of text in visual mode
mapper("x", "K", ":move '<-2<CR>gv-gv")
mapper("x", "J", ":move '>+1<CR>gv-gv")

mapper("n", "<leader>/", ":CommentToggle<CR>")
mapper("v", "<leader>/", ":CommentToggle<CR>")

-- MAPPINGS
mapper("n", "<S-t>", [[<Cmd>tabnew<CR>]]) -- new tab
mapper("n", "<S-x>", [[<Cmd>bdelete!<CR>]]) -- close tab

-- Diffview
mapper("n", "<leader>gD", "<cmd>DiffviewOpen --untracked-files=no<CR>")
mapper("n", "<leader>gH", "<cmd>DiffviewFileHistory %<CR>")

vim.cmd("tnoremap <Esc> <C-\\><C-n><CR>")

-- Whatever you delete, make it go away
set({ "n", "x" }, "c", '"_c')
set(nxo, "%", "gg0vG$")
set({ "n", "x" }, "C", '"_C')

set({ "n", "x" }, "x", '"_x')
set("x", "X", '"_c')

return mapper
