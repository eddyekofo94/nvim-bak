-- for completion
vim.o.completeopt = "menu,menuone,noselect"

-- Setup nvim-cmp.
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
        vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")
local kind_icons = O.kind_icons
local lspkind = require("lspkind")
local visible_buffers = require("utils").visible_buffers

lspkind.init({
    symbol_map = kind_icons,
})

cmp.setup({
    snippet = {
        expand = function(args)
            -- For `luasnip` user.
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- Testing
        ["<c-q>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<C-Space>"] = cmp.mapping({
            i = cmp.mapping.complete(),
            c = function(
                _ --[[fallback]]
            )
                if cmp.visible() then
                    if not cmp.confirm({ select = true }) then
                        return
                    end
                else
                    cmp.complete()
                end
            end,
        }),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    },
    sources = {
        { name = "luasnip", keyword_length = 2 },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "neorg" },
        { name = "path" },
        {
            name = "buffer",
            max_item_count = 3,
            keyword_length = 3,
            option = {
                get_bufnrs = visible_buffers, -- Suggest words from all visible buffers
            },
        },
        { name = "calc" },
        { name = "spell" },
        { name = "treesitter" },
        { name = "crates" },
    },
    window = {
        completion = {
            col_offset = -2,  -- To fit lspkind icon
            side_padding = 1, -- One character margin
        },
    },
    formatting = {
        format = lspkind.cmp_format({
            with_text = false,
            maxwidth = 50,        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            mode = 'symbol_text', -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
            menu = {
                nvim_lsp = "(LSP)",
                luasnip = "(LuaSnip)",
                emoji = "(Emoji)",
                path = "(Path)",
                calc = "(Calc)",
                buffer = "(Buffer)",
            },
        }),
        -- format = function(entry, vim_item)
        --     vim_item.kind = kind_icons[vim_item.kind] .. " " .. vim_item.kind
        --     vim_item.menu = ({
        --         nvim_lsp = "(LSP)",
        --         luasnip = "(LuaSnip)",
        --         emoji = "(Emoji)",
        --         path = "(Path)",
        --         calc = "(Calc)",
        --         buffer = "(Buffer)",
        --     })[entry.source.name]
        --     vim_item.maxwidth = 50 -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        --     vim_item.dup = ({
        --             buffer = 1,
        --             path = 1,
        --             nvim_lsp = 0,
        --         })[entry.source.name] or 0
        --     return vim_item
        -- end,
    },
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
    }),
})
