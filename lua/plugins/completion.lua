return {
    "hrsh7th/nvim-cmp",
    event = { "CmdlineEnter", "InsertEnter" },
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
        },
        { "rafamadriz/friendly-snippets" },
    },
    config = function()
        -- Setup nvim-cmp.
        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and
                vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") ==
                nil
        end

        local luasnip = require("luasnip")
        local cmp = require("cmp")
        local lspkind = require("lspkind")
        local visible_buffers = require("utils").visible_buffers
        local compare = require('cmp.config.compare')
        local types = require("cmp.types")


        ---@type table<integer, integer>
        local modified_priority = {
            [types.lsp.CompletionItemKind.Snippet] = 0, -- top
            [types.lsp.CompletionItemKind.Variable] = types.lsp.CompletionItemKind.Variable,
            [types.lsp.CompletionItemKind.Keyword] = 1, -- top
            [types.lsp.CompletionItemKind.Text] = 100,  -- bottom
        }

        ---@param kind integer: kind of completion entry
        local function modified_kind(kind)
            return modified_priority[kind] or kind
        end

        lspkind.init({
            preset = 'codicons',
        })

        cmp.setup({
            enabled = function()
                local buftype = vim.api.nvim_buf_get_option(0, "buftype")
                if buftype == "prompt" then return false end -- no suggestions on promt: Telescope
                -- disable completion in comments
                local context = require 'cmp.config.context'
                -- keep command mode completion enabled when cursor is in a comment.
                if vim.api.nvim_get_mode().mode == 'c' then
                    return true
                else
                    return not context.in_treesitter_capture("comment")
                        and not context.in_syntax_group("Comment")
                end
            end,
            completion = {
                completeopt = 'menu,menuone,noinsert',
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            matching = {
                disallow_fuzzy_matching = false,
                disallow_fullfuzzy_matching = false,
                disallow_partial_fuzzy_matching = false,
            },
            mapping = {
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<c-q>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
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
                    select = false,
                }),
                ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
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
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
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
                {
                    name = "luasnip",
                    keyword_length = 2,
                    option = {
                        show_autosnippets = true },
                },
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
                completion = cmp.config.window.bordered({
                    winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual",
                    col_offset = -3,
                    side_padding = 1,
                }),
                documentation = cmp.config.window.bordered({
                    winhighlight =
                    "Normal:Normal,FloatBorder:CmpBorder,CursorLine:Visual,Search:None",
                    side_padding = 1,
                }),
            },
            sorting = {
                priority_weight = 1.0,
                comparators = {
                    compare.locality,
                    function(entry1, entry2) -- sort by length ignoring "=~"
                        local len1 = string.len(string.gsub(entry1.completion_item.label, "[=~()]",
                            ""))
                        local len2 = string.len(string.gsub(entry2.completion_item.label, "[=~()]",
                            ""))
                        if len1 ~= len2 then
                            return len1 - len2 < 0
                        end
                    end,
                    compare.recently_used,
                    compare.exact,
                    function(entry1, entry2) -- sort by compare kind (Variable, Function etc)
                        local kind1 = modified_kind(entry1:get_kind())
                        local kind2 = modified_kind(entry2:get_kind())
                        if kind1 ~= kind2 then
                            return kind1 - kind2 < 0
                        end
                    end,
                    function(entry1, entry2) -- score by lsp, if available
                        local t1 = entry1.completion_item.sortText
                        local t2 = entry2.completion_item.sortText
                        if t1 ~= nil and t2 ~= nil and t1 ~= t2 then
                            return t1 < t2
                        end
                    end,
                    compare.order,
                    compare.offset,
                },
            },
            experimental = {
                ghost_text = true,
            },
            formatting = {
                -- fields = { "abbr", "kind", "menu" },
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(
                        entry, vim_item)
                    local strings = vim.split(kind.kind, "%s", { trimempty = true })
                    kind.kind = " " .. (strings[1] or "") .. " "
                    kind.menu = "    (" .. (strings[2] or "") .. ")"
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
