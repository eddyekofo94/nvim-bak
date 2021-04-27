-- Initialize plugins
require("plugins.telescope")
require("plugins.web-devicons")
require("plugins.autopairs")
-- inoremap <silent><expr> <C-Space> compe#complete()
-- inoremap <silent><expr> <CR>      compe#confirm('<CR>')

-- nvim-comment
require("nvim_comment").setup()
vim.api.nvim_set_keymap("n", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
