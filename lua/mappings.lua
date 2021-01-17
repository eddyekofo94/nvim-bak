-- Mapping helper
local mapper = function(mode, key, result)
    vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

-- Telescope integration
mapper("n", "<Leader>ff", "<cmd>lua require'telescope.builtin'.find_files{}<CR>")     -- search all files, respecting .gitignore if one exists
mapper("n", "<Leader>fb", "<cmd>lua require'telescope.builtin'.buffers{}<CR>")        -- search open buffers
mapper("n", "<Leader>fl", "<cmd>lua require'telescope.builtin'.treesitter{}<CR>")     -- search symbols in current buffer
mapper("n", "<Leader>gg", "<cmd>lua require'telescope.builtin'.live_grep{}<CR>")      -- search all lines in project
mapper("n", "<Leader>fr", "<cmd>lua require'telescope.builtin'.lsp_references{}<CR>") -- search references to symbol under cursor
mapper("n", "<Leader>co", "<cmd>lua require'telescope.builtin'.colorscheme{}<CR>")    -- Fuzzy find colorschemes
mapper("n", "<Leader>cm", "<cmd>lua require'telescope.builtin'.commands{}<CR>")       -- command history
