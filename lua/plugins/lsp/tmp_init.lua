return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "neovim/nvim-lspconfig" }, -- Required
            { "williamboman/mason.nvim" }, -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional
            -- Autocompletion
            {
                "hrsh7th/nvim-cmp",
                config = function()
                    -- for completion
                    vim.o.completeopt = "menu,menuone,noselect"

                    -- Setup nvim-cmp.
                    local has_words_before = function()
                        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                        return col ~= 0
                            and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s")
                            == nil
                    end

                    local luasnip = require("luasnip")
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
                            { name = "nvim_lsp" },
                            { name = "luasnip" },
                            { name = "nvim_lua" },
                            { name = "neorg" },
                            { name = "path" },
                            { name = "buffer", keyword_length = 4 },
                            { name = "calc" },
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
                        }, {
                            { name = "cmdline" },
                        }),
                    })
                end,
            }, -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "hrsh7th/cmp-buffer" }, -- Optional
            { "hrsh7th/cmp-path" }, -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" }, -- Optional
            { "hrsh7th/cmp-cmdline" },
            { "onsails/lspkind-nvim" },
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
            { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
            "hrsh7th/cmp-nvim-lsp",
            {
                "folke/neodev.nvim",
                opts = { experimental = { pathStrict = true } },
            },
            "simrat39/rust-tools.nvim",
            {
                "j-hui/fidget.nvim",
                config = function()
                    require("fidget").setup({
                        window = {
                            blend = 0,
                        },
                    })
                end,
            },
            {
                "williamboman/mason.nvim",
                config = function()
                    require("mason").setup()
                end,
            },
            "williamboman/mason-lspconfig.nvim",
            {
                "folke/lsp-trouble.nvim",

                config = function()
                    -- mapped to <space>lt -- this shows a list of diagnostics
                    require("trouble").setup({
                        height = 15, -- height of the trouble list
                        mode = "document_diagnostics",
                        action_keys = {
                            -- key mappings for actions in the trouble list
                            close = "q", -- close the list
                            cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
                            refresh = "r", -- manually refresh
                            jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
                            jump_close = { "o" }, -- jump to the diagnostic and close the list
                            toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
                            toggle_preview = "P", -- toggle auto_preview
                            hover = "K", -- opens a small poup with the full multiline message
                            preview = "p", -- preview the diagnostic location
                            close_folds = { "zM", "zm" }, -- close all folds
                            open_folds = { "zR", "zr" }, -- open all folds
                            toggle_fold = { "zA", "za" }, -- toggle fold of current file
                            previous = "k", -- preview item
                            next = "j", -- next item
                        },
                    })
                end,
            },
        },
        config = function()
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")
            -- local lsp_conf = require("plugins.lsp.lsp_conf")

            local mapper = function(mode, key, result)
                vim.api.nvim_buf_set_keymap(
                    0,
                    mode,
                    key,
                    "<cmd>lua " .. result .. "<CR>",
                    { noremap = true, silent = true }
                )
            end

            local custom_init = function(client)
                client.config.flags = client.config.flags or {}
                client.config.flags.allow_incremental_sync = true
            end
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            mason_lspconfig.setup({
                ensure_installed = {
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
                },
            })

            local custom_attach = function(client, bufnr)
                if client.config.flags then
                    client.config.flags.allow_incremental_sync = true
                end

                -- set up mappings (only apply when LSP client attached)
                mapper("n", "<space>dD", "vim.lsp.buf.declaration()")
                mapper("n", "<space>di", "vim.lsp.buf.implementation()")
                mapper("n", "<c-]>", "vim.lsp.buf.definition()")
                mapper("n", "<space>dR", "vim.lsp.buf.references()")
                mapper("n", "<space>dR", "vim.lsp.buf.references()")
                mapper("n", "H", "vim.lsp.buf.code_action()")
                mapper("n", "<space>dc", "vim.lsp.buf.incoming_calls()")
                mapper("n", "<space>da", "vim.diagnostic.setloclist()")
                mapper("n", "[d", "vim.diagnostic.goto_prev()")
                mapper("n", "]d", "vim.diagnostic.goto_next()")

                capabilities.textDocument.completion.completionItem.snippetSupport = true
                capabilities.textDocument.completion.completionItem.resolveSupport = {
                    properties = { "documentation", "detail", "additionalTextEdits" },
                }

                -- Setup lspconfig.
                capabilities = require("cmp_nvim_lsp").default_capabilities()

                -- NOTE: This enables highlighting, might need to look at removing the popup
                -- Set autocommands conditional on server_capabilities
                if client.server_capabilities.document_highlight then
                    vim.api.nvim_exec(
                        [[
                            hi LspReferenceRead cterm=bold ctermbg=None guibg=#393f4a  guifg=None
                            hi LspReferenceText cterm=bold ctermbg=None guibg=#393f4a guifg=None
                            hi LspReferenceWrite cterm=bold ctermbg=None guibg=#393f4a guifg=None
                            augroup lsp_document_highlight
                            autocmd!
                            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                            augroup END
                        ]],
                        false
                    )
                end

                vim.lsp.handlers["textDocument/publishDiagnostics"] =
                vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                    underline = true,
                    -- Hide/Show virtual text
                    virtual_text = {
                        prefix = "",
                        severity_limit = "Warning",
                    },
                    -- Increase diagnostic signs priority
                    signs = { priority = 9999 },
                    update_in_insert = true,
                })

                -- TODO: look into fixing this maybe
                -- if client.server_capabilities.documentSymbolProvider then
                --     navic.attach(client, bufnr)
                -- end

                local filetype = vim.api.nvim_buf_get_option(0, "filetype")

                -- Set some keybinds conditional on server capabilities
                if client.server_capabilities.document_formatting then
                    mapper("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>")
                elseif client.server_capabilities.document_range_formatting then
                    mapper("n", "<leader>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>")
                end
                if vim.tbl_contains({ "go", "rust" }, filetype) then
                    vim.cmd([[autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()]])
                end

                if filetype ~= "lua" then
                    mapper("n", "K", "vim.lsp.buf.hover()")
                end
                if filetype == "cpp" then
                    vim.api.nvim_buf_set_keymap(
                        0,
                        "n",
                        "<s-f>",
                        "<cmd>ClangdSwitchSourceHeader<CR>",
                        { noremap = true, silent = true }
                    )
                end

                vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
            end

            mason_lspconfig.setup_handlers({
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name) -- default handler (optional)
                    lspconfig[server_name].setup({
                        on_attach = custom_attach,
                        -- flags = lsp_flags,
                    })
                end,
                -- Next, you can provide a dedicated handler for specific servers.
                -- For example, a handler override for the `rust_analyzer`:
                ["rust_analyzer"] = function()
                    require("rust-tools").setup({})
                    lspconfig.rust_analyzer.setup({
                        cmd = { "rust-analyzer" },
                        filetypes = { "rust" },
                        on_attach = custom_attach,
                        capabilities = capabilities,
                        handlers = {
                            ["textDocument/publishDiagnostics"] = vim.lsp.with(
                                vim.lsp.diagnostic.on_publish_diagnostics,
                                {
                                    signs = true,
                                    virtual_text = {
                                        prefix = "",
                                    },
                                    update_in_insert = true,
                                }
                            ),
                        },
                    })
                end,
                ["vimls"] = function()
                    lspconfig.vimls.setup({
                        on_init = custom_init,
                        on_attach = custom_attach,
                        capabilities = capabilities,
                    })
                end,
                -- TODO: Add cmake
                ["bashls"] = function()
                    lspconfig.bashls.setup({
                        on_init = custom_init,
                        on_attach = custom_attach,
                        capabilities = capabilities,
                    })
                end,
                -- BUG: this seems to not be working
                ["cucumber_language_server"] = function()
                    lspconfig.cucumber_language_server.setup({
                        on_init = custom_init,
                        on_attach = custom_attach,
                        capabilities = capabilities,
                    })
                end,
                ["pylsp"] = function()
                    lspconfig.pylsp.setup({
                        on_init = custom_init,
                        on_attach = custom_attach,
                        capabilities = capabilities,
                        settings = {
                            pylsp = {
                                plugins = {
                                    pycodestyle = {
                                        ignore = { "W391" },
                                        maxLineLength = 100,
                                    },
                                },
                            },
                        },
                    })
                end,
                ["yamlls"] = function()
                    lspconfig.yamlls.setup({
                        on_init = custom_init,
                        on_attach = custom_attach,
                    })
                end,
                ["clangd"] = function()
                    lspconfig.clangd.setup({
                        cmd = {
                            "clangd",
                            "--background-index",
                            "--suggest-missing-includes",
                            "--clang-tidy",
                            "--header-insertion=iwyu",
                        },
                        on_init = custom_init,
                        on_attach = custom_attach,
                        -- Required for lsp-status
                        init_options = { clangdFileStatus = true },
                        capabilities = capabilities,
                    })
                end,
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        on_init = custom_init,
                        on_attach = custom_attach,
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                completion = {
                                    callSnippet = "Replace",
                                },
                                runtime = {
                                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                                    version = "LuaJIT",
                                },
                                diagnostics = {
                                    globals = { "vim" },
                                },
                                workspace = {
                                    -- Make the server aware of Neovim runtime files
                                    workspace = {
                                        library = vim.api.nvim_get_runtime_file("", true),
                                        checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
                                    },
                                },
                                telemetry = {
                                    enable = false,
                                },
                            },
                        },
                    })
                end,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function()
                    local bufmap = function(mode, lhs, rhs)
                        local opts = { buffer = true }
                        vim.keymap.set(mode, lhs, rhs, opts)
                    end

                    bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
                    bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
                    bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
                    bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
                    bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
                    bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
                    bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
                    bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
                    bufmap("x", "<F4>", "<cmd>lua vim.lsp.buf.range_code_action()<cr>")
                    bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
                    bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
                    bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
                end,
            })

            vim.diagnostic.config({
                virtual_text = false,
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })
        end,
    },
}
