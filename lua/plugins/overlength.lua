return {
    'lcheylus/overlength.nvim',
    lazy = false,
    config = function()
        require('overlength').setup({
            bg                 = "#840000",
            default_overlength = nil, -- INFO: seems to not work
            disable_ft         = { "dashboard", "which-key", "lazygit" },
        })
        require('overlength').set_overlength({ "go", "lua" }, 120)
        require('overlength').set_overlength({ "cpp", "bash" }, 80)
        require('overlength').set_overlength({ "rust", "python" }, 100)
    end,
}
