----------------------
-- Refactoring.nvim --
----------------------
return {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" },
    },
    event = "BufEnter",
    keys = {
        { '<leader>r',  mode = 'x' , desc = "Refactor"},
        { "<leader>rf", "<cmd>Refactor extract_to_file<cr>", mode = "x" },
        { "<leader>rv", "<cmd>Refactor extract_var<cr>",     mode = "x" },
        {
            "<leader>ri", "<cmd>Refactor inline_var<cr>", mode = { "n", "x" },
        },
        { "<leader>rb",  "<cmd>Refactor extract_block<cr>",         mode = "n" },
        { "<leader>rbf", "<cmd>Refactor extract_block_to_file<cr>", mode = "n" },
        {
            "<leader>rr",
            ":lua require('refactoring').select_refactor()<CR>",
            mode = "v",
        },
    },
    config = function()
        require('refactoring').setup({})
        require('telescope').load_extension('refactoring')
    end,
}
