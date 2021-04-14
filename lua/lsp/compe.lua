
require "compe".setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    allow_prefix_unmatch = false,
    source = {
        ultisnips = true,
        nvim_lsp = true,
        path = true,
        buffer = true,
        vsnip = true,
        nvim_lua = true,
        spell = true
    }
}

local mapper = function(mode, key, result)
    vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end
-- vim.api.nvim_set_keymap
mapper("i", "<expr> <C-Space>", "compe#complete()")
mapper("i", "<expr> <CR>", "compe#confirm('<CR>')")
mapper("i", "<expr> <C-e>", "compe#close('<C-e>')")

