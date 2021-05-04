-- Mapping helper
local mapper = function(mode, key, result)
    vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

-- Telescope integration
-- mapper("n", "<Leader>ff", "<cmd>lua require'telescope.builtin'.find_files{}<CR>") -- search all files, respecting .gitignore if one exists
-- mapper("n", "<Leader>fb", "<cmd>lua require'telescope.builtin'.buffers{}<CR>") -- search open buffers
-- mapper("n", "<Leader>fl", "<cmd>lua require'telescope.builtin'.treesitter{}<CR>") -- search symbols in current buffer
-- mapper("n", "<Leader>gg", "<cmd>lua require'telescope.builtin'.live_grep{}<CR>") -- search all lines in project
-- mapper("n", "<Leader>fr", "<cmd>lua require'telescope.builtin'.lsp_references{}<CR>") -- search references to symbol under cursor
-- mapper("n", "<Leader>co", "<cmd>lua require'telescope.builtin'.colorscheme{}<CR>") -- Fuzzy find colorschemes
-- mapper("n", "<Leader>cm", "<cmd>lua require'telescope.builtin'.commands{}<CR>") -- command history
mapper("n", "q", ":wq<CR>") -- force write before quit TODO: see if it's a good idea or not

     vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", {noremap = true, silent = true})
vim.g.mapleader = " "
vim.cmd("let g:UltiSnipsExpandTrigger = '<F5>'")

-- no hl
vim.api.nvim_set_keymap("n", "<Leader>h", ":set hlsearch!<CR>", {noremap = true, silent = true})

-- explorer
vim.api.nvim_set_keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", {noremap = true, silent = true})

-- better window movement
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", {silent = true})
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", {silent = true})
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", {silent = true})
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", {silent = true})

-- better indenting
vim.api.nvim_set_keymap("v", "<", "<gv", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", ">", ">gv", {noremap = true, silent = true})

-- I hate escape
vim.api.nvim_set_keymap("i", "jk", "<ESC>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("i", "kj", "<ESC>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("i", "jj", "<ESC>", {noremap = true, silent = true})

-- Tab switch buffer
vim.api.nvim_set_keymap("n", "<TAB>", ":bnext<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<S-TAB>", ":bprevious<CR>", {noremap = true, silent = true})

-- Move selected line / block of text in visual mode
vim.api.nvim_set_keymap("x", "K", ":move '<-2<CR>gv-gv", {noremap = true, silent = true})
vim.api.nvim_set_keymap("x", "J", ":move '>+1<CR>gv-gv", {noremap = true, silent = true})

-- Better nav for omnicomplete
vim.cmd('inoremap <expr> <c-j> ("\\<C-n>")')
vim.cmd('inoremap <expr> <c-k> ("\\<C-p>")')

-- Terminal: exiting the terminal mode
-- vim.api.nvim_set_keymap("tn", )
vim.cmd("tnoremap <Esc> <C-\\><C-n><CR>")

return mapper
