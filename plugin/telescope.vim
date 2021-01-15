
" Telescope: keymaps.
" TODO: map to quick_view, map git_files
lua << EOF
require('telescope').setup {
  defaults = {
    sorting_strategy = "ascending",
    prompt_position = "top",
  }
}
EOF
" Using lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>gf <cmd>lua require('telescope.builtin').git_files()<cr>
