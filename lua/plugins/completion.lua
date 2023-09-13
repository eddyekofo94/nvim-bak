return {
    "hrsh7th/nvim-cmp",
    event = { "CmdlineEnter", "InsertEnter" },
    dependencies = {
        { "lukas-reineke/cmp-rg" },
        { "hrsh7th/cmp-buffer" },       -- Optional
        { "ray-x/cmp-treesitter" },
        { "hrsh7th/cmp-path" },         -- Optional
        { "saadparwaiz1/cmp_luasnip" }, -- Optional
        { "hrsh7th/cmp-nvim-lua" },     -- Optional
        { "hrsh7th/cmp-nvim-lsp-signature-help" },
        { "hrsh7th/cmp-cmdline" },
        { "dmitmel/cmp-cmdline-history" },
        { "onsails/lspkind-nvim" },
        { "hrsh7th/cmp-nvim-lsp" }, -- Required
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
    },
    config = function()
        -- Setup nvim-cmp.
        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and
                vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") ==
                nil
        end

        local t = function(str)
            return vim.api.nvim_replace_termcodes(str, true, true, true)
        end

        local luasnip = require("luasnip")
        local cmp = require("cmp")
        local lspkind = require("lspkind")
        local visible_buffers = require("utils").visible_buffers
        local compare = require('cmp.config.compare')
        local types = require("cmp.types")

        ---@type table<integer, integer>
        local modified_priority = {
            [types.lsp.CompletionItemKind.Variable] = 1,
            [types.lsp.CompletionItemKind.Constant] = 1,
            [types.lsp.CompletionItemKind.Snippet] = 1, -- top
            [types.lsp.CompletionItemKind.Keyword] = 2, -- top
            [types.lsp.CompletionItemKind.Function] = types.lsp.CompletionItemKind.Method,
            [types.lsp.CompletionItemKind.Text] = 100,  -- bottom
        }

        ---@param kind integer: kind of completion entry
        local function modified_kind(kind)
            return modified_priority[kind] or kind
        end

        lspkind.init({
            preset = 'codicons',
        })

        ---@diagnostic disable-next-line: missing-fields
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
            keyword_length = 2,
            preselect = cmp.PreselectMode.Item,
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
                    i = function(fallback)
                        if cmp.visible() and cmp.get_active_entry() then
                            cmp.confirm({
                                -- For Copilot -- INFO: not using this (yet)
                                behavior = cmp.ConfirmBehavior.Replace,
                                -- Only when explicitly selected
                                select = false,
                            })
                        else
                            fallback()
                        end
                    end,
                    s = cmp.mapping.confirm({ select = true }),
                    c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    -- behavior = cmp.ConfirmBehavior.Insert,
                    -- select = true,
                }),
                ["<C-j>"] = cmp.mapping({
                    c = function()
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
                        end
                    end,
                    i = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end,
                }),
                ['<C-k>'] = cmp.mapping({
                    c = function()
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
                        end
                    end,
                    i = function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end,
                }),
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
                    keyword_length = 1,
                    max_item_count = 3,
                    option = {
                        use_show_condition = true,
                        show_autosnippets = true,
                    },
                    entry_filter = function()
                        local context = require("cmp.config.context")
                        return not context.in_treesitter_capture("string") and
                            not context.in_syntax_group("String")
                    end,
                },
                {
                    name = "nvim_lsp",
                    priority_weight = 85,
                    max_item_count = 50,
                },
                { name = "nvim_lua" },
                { name = "nvim_lsp_signature_help" },
                {
                    name = "treesitter",
                    priority_weight = 80,
                    max_item_count = 5,
                },
                { name = "neorg" },
                { name = "path", priority_weight = 100, max_item_count = 40 },
                {
                    name = "buffer",
                    max_item_count = 3,
                    keyword_length = 4,
                    dup = 0,
                    option = {
                        get_bufnrs = visible_buffers, -- Suggest words from all visible buffers
                    },
                },
                {
                    name = "rg",
                    priority_weight = 60,
                    max_item_count = 10,
                    keyword_length = 4,
                    option = {
                        additional_arguments = "--smart-case",
                    },
                },
                { name = "spell", keyword_length = 3, priority = 5, keyword_pattern = [[\w\+]] },
                { name = "calc" },
            },
            view = {
                entries = { name = "custom", selection_order = "near_cursor" },
            },
            window = {
                completion = cmp.config.window.bordered({
                    winhighlight = "FloatBorder:CmpBorder",
                    col_offset = -3,
                    side_padding = 0,
                }),
                documentation = cmp.config.window.bordered({
                    winhighlight =
                    "Normal:Normal,FloatBorder:CmpBorder,CursorLine:Visual,Search:None",
                    side_padding = 1,
                }),
            },
            sorting = {
                priority_weight = 2,
                comparators = {
                    compare.exact,
                    function(entry1, entry2) -- sort by compare kind (Variable, Function etc)
                        local kind1 = modified_kind(entry1:get_kind())
                        local kind2 = modified_kind(entry2:get_kind())
                        if kind1 ~= kind2 then
                            return kind1 - kind2 < 0
                        end
                    end,
                    compare.recently_used,
                    compare.scopes,
                    function(entry1, entry2) -- sort by length ignoring "=~"
                        local len1 = string.len(string.gsub(entry1.completion_item.label, "[=~()]",
                            ""))
                        local len2 = string.len(string.gsub(entry2.completion_item.label, "[=~()]",
                            ""))
                        if len1 ~= len2 then
                            return len1 - len2 < 0
                        end
                    end,
                    function(entry1, entry2) -- score by lsp, if available
                        local t1 = entry1.completion_item.sortText
                        local t2 = entry2.completion_item.sortText
                        if t1 ~= nil and t2 ~= nil and t1 ~= t2 then
                            return t1 < t2
                        end
                    end,
                    compare.locality,
                },
            },
            experimental = {
                ghost_text = true,
            },
            formatting = {
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
                { name = 'nvim_lsp_document_symbol' },
                { name = "buffer" },
            },
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            enabled = function()
                -- Set of commands where cmp will be disabled
                local disabled = {
                    IncRename = true,
                }
                -- Get first word of cmdline
                local cmd = vim.fn.getcmdline():match("%S+")
                -- Return true if cmd isn't disabled
                -- else call/return cmp.close(), which returns false
                return not disabled[cmd] or cmp.close()
            end,
            sources = cmp.config.sources({
                { name = "cmdline",         max_item_count = 30 },
                { name = "cmdline_history", max_item_count = 10 },
                { name = "path",            max_item_count = 20 },
            }),
        })

        cmp.setup.filetype('query', {
            sources = {
                { name = 'omni' },
            },
        })
    end,
}
