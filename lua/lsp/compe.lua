vim.o.completeopt = "menuone,noselect"

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
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,
    source = {
        ultisnips = {kind = "  "}, -- TODO: why the lspkind not working
        nvim_lsp = {kind = "  "},
        buffer = {kind = "  "},
        spell = {kind = "  "},
        path = {kind = "  "},
        calc = {kind = "  "},
        vsnip = {kind = "  "},
        nvim_lua = true,
        tags = false,
        vim_dadbod_completion = true,
        -- snippets_nvim = {kind = "  "},
        treesitter = {kind = "  "},
        emoji = {kind = " ﲃ ", filetypes = {"markdown", "text"}}
    }
    -- source = {
    --     ultisnips = true,
    --     nvim_lsp = true,
    --     path = true,
    --     buffer = true,
    --     vsnip = true,
    --     nvim_lua = true,
    --     spell = true
    -- while
    -- }
}

local mapper = function(mode, key, result)
    vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end
-- vim.api.nvim_set_keymap
mapper("i", "<expr> <C-Space>", "compe#complete()")
mapper("i", "<expr> <CR>", "compe#confirm('<CR>')")
mapper("i", "<expr> <C-e>", "compe#close('<C-e>')")

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif vim.fn.call("vsnip#available", {1}) == 1 then
        return t "<Plug>(vsnip-expand-or-jump)"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn["compe#complete"]()
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug(vsnip-jump-prev)"
    else
        return t "<S-Tab>"
    end
end

-- TODO: I don't think this is working
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
