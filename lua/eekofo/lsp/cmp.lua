vim.o.completeopt = "menu,menuone,noselect"

-- Setup nvim-cmp.
local cmp = require("cmp")
local kind_icons = {
    Class = " ",
    Color = " ",
    Constant = "ﲀ ",
    Constructor = " ",
    Enum = "練",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = "",
    Folder = " ",
    Function = " ",
    Interface = "ﰮ ",
    Keyword = " ",
    Method = " ",
    Module = " ",
    Operator = "",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = "塞",
    Value = " ",
    Variable = " ",
}

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
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<TAB>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<S-TAB>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "luasnip" },
        { name = "cmp_tabnine" },
        { name = "nvim_lua" },
        { name = "buffer" },
        { name = "calc" },
        { name = "emoji" },
        { name = "spell" },
        { name = "treesitter" },
        { name = "crates" },
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = kind_icons[vim_item.kind] .. " " .. vim_item.kind
            vim_item.menu = ({
                nvim_lsp = "(LSP)",
                luasnip = "(Snippet)",
                emoji = "(Emoji)",
                path = "(Path)",
                calc = "(Calc)",
                cmp_tabnine = "(Tabnine)",
                buffer = "(Buffer)",
            })[entry.source.name]
            vim_item.dup = ({
                buffer = 1,
                path = 1,
                nvim_lsp = 0,
            })[entry.source.name] or 0
            return vim_item
        end,
    }
})
