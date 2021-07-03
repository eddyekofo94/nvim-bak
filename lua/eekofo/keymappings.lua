-- Mapping helper
local mapper = function(mode, key, result)
    vim.api.nvim_set_keymap(mode, key, result, { noremap = true, silent = true })
end

vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.g.mapleader = " "

-- COPY EVERYTHING/ALL
mapper("n", "<C-a>", ": %y+<CR>")
-- SAVE
mapper("n", "<C-s>", ":w!<CR>")

-- explorer
vim.api.nvim_set_keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- better window movement
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { silent = true })

-- better indenting
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- I hate escape
vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "kj", "<ESC>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "jj", "<ESC>", { noremap = true, silent = true })

-- Move selected line / block of text in visual mode
vim.api.nvim_set_keymap("x", "K", ":move '<-2<CR>gv-gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "J", ":move '>+1<CR>gv-gv", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>/", ":CommentToggle<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>", { noremap = true, silent = true })
-- Better nav for omnicomplete
vim.cmd('inoremap <expr> <c-j> ("\\<C-n>")')
vim.cmd('inoremap <expr> <c-k> ("\\<C-p>")')

-- Terminal: exiting the terminal mode
-- vim.api.nvim_set_keymap("tn", )
vim.cmd("tnoremap <Esc> <C-\\><C-n><CR>")
return mapper
