-- Mapping helper
local mapper = require("utils").mapper
local set = require("utils").keymap_set
local utils = require("utils.functions")

vim.g.mapleader = " "
local nxo = require("utils").nxo
vim.cmd("tnoremap <Esc> <C-\\><C-n><CR>")

mapper("n", "<Space>", "<NOP>")

-- Reconsider this option
-- Jump to start and end of line using the home row keys
set({ "n", "v" }, "H", "^")
set({ "n", "v" }, "L", "g_")

-- Easier line-wise movement
set(nxo, 'gh', 'g^')
set(nxo, 'gl', 'g$')

--if vim.lsp.inlay_hint then
--    mapper('n', '<leader>uh', function() vim.lsp.inlay_hint(0, nil) end,
--        { desc = 'Toggle Inlay Hints' })
--end

-- Show treesitter nodes under cursor
-- highlights under cursor
if vim.fn.has('nvim-0.9') == 1 then
    set('n', '<Leader>ui', vim.show_pos, { desc = 'Show Treesitter Node' })
end

-- COPY EVERYTHING/ALL
mapper("n", "<C-a>", ": %y+<CR>")
-- SAVE
mapper("n", "<C-s>", ":w!<CR>")

set(nxo, "p", "p=`]", { desc = "Paste should match indentation" })
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
-- set("v", "y", "may`a", { desc = "Restore cursor position after yank" })

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

set("v", "/", '"fy/\\V<C-R>f<CR>')
set("v", "*", '"fy/\\V<C-R>f<CR>')

set("v", "<c-r>w", ":%s/<c-r><c-w>//g<left><left>")

-- move over a closing element in insert mode
set("i", "<C-l>", function()
    return require("utils.functions").escapePair()
end, { desc = "move over a closing element in insert mode" })


-- cycle through command history without arrow keys
-- INFO: not sure about this
mapper("c", "<c-j>", "<down>")
mapper("c", "<c-k>", "<up>")


-- Search always center
mapper("n", "n", "nzzzv")
mapper("n", "N", "Nzzzv")
mapper("n", "{", "{zzzv")
mapper("n", "}", "}zzzv")
mapper("n", "<C-d>", "<C-d>zzzv")
mapper("n", "<C-u>", "<C-u>zzzv")

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
mapper("i", "jj", "<ESC>")

-- Very magic by default, got this from thePrimragen (Don't know exactly what it
--- does)
-- vim.cmd("nnoremap ? ?\v")
-- vim.cmd("nnoremap / /\v")
-- vim.cmd("cnoremap %s/  %sm/")

-- Move selected line / block of text in visual mode
mapper("x", "K", ":move '<-2<CR>gv-gv")
mapper("x", "J", ":move '>+1<CR>gv-gv")

-- mapper("n", "<leader>/", ":CommentToggle<CR>")
-- mapper("v", "<leader>/", ":CommentToggle<CR>")

-- MAPPINGS
mapper("n", "<S-t>", [[<Cmd>tabnew<CR>]])   -- new tab
mapper("n", "<S-x>", [[<Cmd>bdelete!<CR>]]) -- close tab

-- Diffview
mapper("n", "<leader>gD", "<cmd>DiffviewOpen --untracked-files=no<CR>")
mapper("n", "<leader>gH", "<cmd>DiffviewFileHistory %<CR>")

-- Whatever you delete, make it go away
set({ "n", "x" }, "c", '"_c')
set(nxo, "%", "gg0vG$")
set({ "n", "x" }, "C", '"_C')

set({ "n", "x" }, "x", '"_x')
set("x", "X", '"_c')

return mapper
