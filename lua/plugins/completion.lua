return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        { "lukas-reineke/cmp-rg" },
        { "hrsh7th/cmp-buffer" },       -- Optional
        { "hrsh7th/cmp-path" },         -- Optional
        { "saadparwaiz1/cmp_luasnip" }, -- Optional
        { "hrsh7th/cmp-nvim-lua" },     -- Optional
        { "hrsh7th/cmp-nvim-lsp-signature-help" },
        { "hrsh7th/cmp-cmdline" },
        { "dmitmel/cmp-cmdline-history" },
        { "onsails/lspkind-nvim" },
        { "hrsh7th/cmp-nvim-lsp" }, -- Required
        { "hrsh7th/cmp-nvim-lsp" },
        {
            -- Snippets
            "L3MON4D3/LuaSnip",
            dependencies = {
                "rafamadriz/friendly-snippets",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
            opts = {
                history = true,
                delete_check_events = "TextChanged",
            },
        },                                  -- Required
        { "rafamadriz/friendly-snippets" }, -- Optional
    },
    config = function()
        -- for completion
        vim.o.completeopt = "menu,menuone,noselect"

        -- Setup nvim-cmp.
        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and
                vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") ==
                nil
        end

        local luasnip = require("luasnip")
        local cmp = require("cmp")
        -- local kind_icons = O.kind_icons
        local lspkind = require("lspkind")
        local visible_buffers = require("utils").visible_buffers
        local compare = require('cmp.config.compare')


        lspkind.init({
            -- symbol_map = kind_icons,
            preset = 'codicons',
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
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                }),
                ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
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
                { name = "luasnip",                keyword_length = 2 },
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "nvim_lsp_signature_help" },
                { name = "neorg" },
                { name = "path" },
                { name = "rg",                     keyword_length = 4, dup = 0 },
                {
                    name = "buffer",
                    max_item_count = 3,
                    keyword_length = 3,
                    option = {
                        get_bufnrs = visible_buffers, -- Suggest words from all visible buffers
                    },
                },
                { name = "spell",     keyword_length = 3, priority = 5, keyword_pattern = [[\w\+]] },
                { name = "calc" },
                { name = "treesitter" },
                { name = "crates" },
            },
            window = {
                completion = {
                    -- BUG: seems to break the highlight when selecting an item from the menu
                    -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                    col_offset = -3,
                    side_padding = 0,
                },
                documentation = cmp.config.window.bordered({
                    winhighlight =
                    "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
                }),
            },
            sorting = {
                priority_weight = 1.0,
                comparators = {
                    compare.score,
                    compare.exact,
                    compare.recently_used,
                    compare.length,
                    compare.scopes,
                    compare.locality,
                },
            },
            experimental = {
                ghost_text = true,
            },
            formatting = {
                -- fields = { "abbr", "kind", "menu" },
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    local kind = lspkind.cmp_format({
                        mode = "symbol_text",
                        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                        maxwidth = 50,
                    })(
                        entry, vim_item)
                    local strings = vim.split(kind.kind, "%s", { trimempty = true })
                    kind.kind = " " .. (strings[1] or "") .. " "
                    kind.menu = "    (" .. (strings[2] or "") .. ")"
                    vim_item.dup = ({
                            buffer = 1,
                            path = 1,
                            nvim_lsp = 0,
                        })[entry.source.name] or 0
                    return kind
                end,
                -- format = lspkind.cmp_format({
                --     with_text = false,
                --     maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                --     mode = 'symbol_text',  -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
                --     menu = {
                --         luasnip = "(LuaSnip)",
                --         nvim_lsp = "(LSP)",
                --         emoji = "(Emoji)",
                --         path = "(Path)",
                --         calc = "(Calc)",
                --         buffer = "(Buffer)",
                --     },
                --     dup = ({
                --         buffer = 1,
                --         path = 1,
                --         nvim_lsp = 0,
                --     }),
                -- }),
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
                { name = "cmdline" },
                { name = "cmdline_history" },
                { name = "path" },
            }),
        })
    end,
}