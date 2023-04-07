local utils = require("utils")
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            { "williamboman/mason.nvim" }, -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional
            -- Autocompletion
            { "hrsh7th/nvim-cmp" }, -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "hrsh7th/cmp-buffer" }, -- Optional
            { "hrsh7th/cmp-path" }, -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" }, -- Optional
            { "hrsh7th/cmp-cmdline" },
            {
                "onsails/lspkind-nvim",
            },
            -- Snippets
            {
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
            }, -- Required
            { "rafamadriz/friendly-snippets" }, -- Optional
            "hrsh7th/cmp-nvim-lsp-signature-help",
        },

        config = function()
            vim.o.completeopt = "menu,menuone,noselect"
            local cmp = require("cmp")
            local cmp_action = require("lsp-zero").cmp_action()
            local luasnip = require("luasnip")
            local visible_buffers = require("utils").visible_buffers
            local lspkind = require("lspkind")

            lspkind.init({
                symbol_map = O.kind_icons,
            })

            local cmp_setup = {
                sources = {
                    { name = "luasnip", keyword_length = 2 },
                    { name = "nvim_lsp_signature_help" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    {
                        name = "buffer",
                        max_item_count = 3,
                        keyword_length = 3,
                        option = {
                            get_bufnrs = visible_buffers, -- Suggest words from all visible buffers
                        },
                    },
                    { name = "spell" },
                    { name = "treesitter" },
                    { name = "path" },
                },
                window = {
                    completion = {
                        col_offset = -2, -- To fit lspkind icon
                        side_padding = 1, -- One character margin
                    },
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    completion = {
                        completeopt = "menu,menuone,noinsert",
                    },
                    format = require("lspkind").cmp_format({
                        with_text = true,
                        menu = {
                            luasnip = "[LuaSnip]",
                            nvim_lua = "[nvim]",
                            nvim_lsp = "[LSP]",
                            path = "[path]",
                            buffer = "[buffer]",
                            nvim_lsp_signature_help = "[param]",
                        },
                    }),
                },
                mapping = {
                    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                    ["<C-b>"] = cmp_action.luasnip_jump_backward(),
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
            }

            local lsp = require("lsp-zero")
            lsp.preset("recommended")

            -- NOTE: Given that we want lspsaga to handle this, we omit those keymaps
            lsp.set_preferences({
                set_lsp_keymaps = { omit = { "gd", "K" } },
            })
            lsp.ensure_installed({
                "lua_ls",
                "vimls",
                "rust_analyzer",
                "yamlls",
                "pylsp",
                "dockerls",
                "clangd",
                "bashls",
                "sqlls",
                "cmake",
                "dockerls",
            })
            -- (Optional) Configure lua language server for neovim
            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({ buffer = bufnr }) -- add lsp-zero defaults

                local filetype = vim.api.nvim_buf_get_option(0, "filetype")
                if vim.tbl_contains({ "go", "rust" }, filetype) then
                    vim.cmd([[autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()]])
                end

                utils.lsp_autocmd(
                    "BufEnter",
                    [[
                        hi LspReferenceRead cterm=bold ctermbg=None guibg=#393f4a  guifg=None
                        hi LspReferenceText cterm=bold ctermbg=None guibg=#393f4a guifg=None
                        hi LspReferenceWrite cterm=bold ctermbg=None guibg=#393f4a guifg=None
                        augroup lsp_document_highlight
                        autocmd!
                        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                        augroup END
                    ]]
                )

                if filetype == "cpp" then
                    vim.api.nvim_buf_set_keymap(
                        0,
                        "n",
                        "<s-f>",
                        "<cmd>ClangdSwitchSourceHeader<CR>",
                        { noremap = true, silent = true }
                    )
                end

                if client.supports_method("textDocument/formatting") then
                    utils.lsp_autocmd("BufWritePre", [[LspZeroFormat]])
                end

                vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
            end)

            lsp.setup_nvim_cmp({
                mapping = cmp_setup.mapping,
                sources = cmp_setup.sources,
                formatting = cmp_setup.formatting,
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

            lsp.set_server_config({
                single_file_support = false,
                capabilities = {
                    textDocument = {
                        foldingRange = {
                            dynamicRegistration = false,
                            lineFoldingOnly = true,
                        },
                    },
                },
            })

            lsp.set_sign_icons({
                error = "✘",
                warn = "▲",
                hint = "⚑",
                info = "»",
            })

            lsp.nvim_workspace()
            lsp.setup()
        end,
    },
}
