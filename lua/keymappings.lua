-- Mapping helper
local mapper = function(mode, key, result)
    vim.api.nvim_set_keymap(mode, key, result, { noremap = true, silent = true })
end

mapper("n", "<Space>", "<NOP>")
vim.g.mapleader = " "

-- COPY EVERYTHING/ALL
mapper("n", "<C-a>", ": %y+<CR>")
-- SAVE
mapper("n", "<C-s>", ":w!<CR>")

-- explorer
mapper("n", "<Leader>e", ":Neotree source=filesystem reveal=true position=right toggle=true<CR>")

-- better window movement
mapper("n", "<C-h>", "<C-w>h")
mapper("n", "<C-j>", "<C-w>j")
mapper("n", "<C-k>", "<C-w>k")
mapper("n", "<C-l>", "<C-w>l")

-- better indenting
mapper("v", "<", "<gv")
mapper("v", ">", ">gv")

-- I hate escape
mapper("i", "jk", "<ESC>")
mapper("i", "kj", "<ESC>")
mapper("i", "jj", "<ESC>")

-- Move selected line / block of text in visual mode
mapper("x", "K", ":move '<-2<CR>gv-gv")
mapper("x", "J", ":move '>+1<CR>gv-gv")

mapper("n", "<leader>/", ":CommentToggle<CR>")

mapper("v", "<leader>/", ":CommentToggle<CR>")
-- Better nav for omnicomplete
vim.cmd('inoremap <expr> <c-j> ("\\<C-n>")')
vim.cmd('inoremap <expr> <c-k> ("\\<C-p>")')

-- MAPPINGS
mapper("n", "<S-t>", [[<Cmd>tabnew<CR>]]) -- new tab
mapper("n", "<S-x>", [[<Cmd>bdelete!<CR>]]) -- close tab
-- Terminal: exiting the terminal mode
-- mapper("tn", )
vim.cmd("tnoremap <Esc> <C-\\><C-n><CR>")
return mapper
