local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local utils = require("utils")
local wk = require("which-key")

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

local capabilities = vim.lsp.protocol.make_client_capabilities()

local mapper = function(mode, key, result)
    vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. result .. "<CR>",
        { noremap = true, silent = true })
end
local custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end
local signs_defined = O.signs

local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = "",
    })
end

local custom_attach = function(client, bufnr)
    if client.config.flags then
        client.config.flags.allow_incremental_sync = true
    end

    -- set up mappings (only apply when LSP client attached)
    mapper("n", "<space>dD", "vim.lsp.buf.declaration()")
    mapper("n", "<space>di", "vim.lsp.buf.implementation()")
    mapper("n", "<c-]>", "vim.lsp.buf.definition()")
    mapper("n", "<space>dR", "vim.lsp.buf.references()")
    -- mapper("n", "H", "vim.lsp.buf.code_action()")
    mapper("n", "<space>dc", "vim.lsp.buf.incoming_calls()")
    mapper("n", "<space>da", "vim.diagnostic.setloclist()")
    mapper("n", "[d", "vim.diagnostic.goto_prev()")
    mapper("n", "]d", "vim.diagnostic.goto_next()")

    sign({ name = "DiagnosticSignError", text = signs_defined.error })
    sign({ name = "DiagnosticSignWarn", text = signs_defined.warn })
    sign({ name = "DiagnosticSignHint", text = signs_defined.hint })
    sign({ name = "DiagnosticSignInfo", text = signs_defined.info })

    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = { "documentation", "detail", "additionalTextEdits" },
    }
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")

    -- INFO: Use different ways to auto_format
    utils.auto_format()

    local format_code
    if client.supports_method("textDocument/formatting") then
        format_code = "<cmd>lua vim.lsp.buf.format()<CR>"
    elseif client.supports_method("textDocument/rangeFormatting") then
        format_code = "<cmd>lua vim.lsp.buf.range_formatting()<CR>"
    elseif vim.tbl_contains({ "go", "rust" }, filetype) then
        format_code = "<cmd>lua vim.lsp.buf.formatting_sync()<CR>"
    else
        format_code = "<cmd>Format<CR>"
    end

    wk.register({
        f = { format_code, "Format code" }, -- create a binding with label
    }, { prefix = "<leader>" })

    -- Only highlight if compatible with the language
    if client.server_capabilities.documentHighlightProvider then
        vim.cmd([[
            hi! LspReferenceRead cterm=bold ctermbg=None guibg=#585B70 guifg=None
            hi! LspReferenceText cterm=bold ctermbg=None guibg=#585B70 guifg=None
            hi! LspReferenceWrite cterm=bold ctermbg=None guibg=#6C7086 guifg=None
        ]])

        local api = vim.api
        local lsp = vim.lsp
        local gid = api.nvim_create_augroup("lsp_document_highlight", { clear = true })

        api.nvim_create_autocmd("CursorHold", {
            group = gid,
            buffer = bufnr,
            callback = function()
                lsp.buf.document_highlight()
            end,
        })

        api.nvim_create_autocmd("CursorMoved", {
            group = gid,
            buffer = bufnr,
            callback = function()
                lsp.buf.clear_references()
            end,
        })
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

    -- Setup lspconfig.
    capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            underline = true,
            -- Hide/Show virtual text
            virtual_text = {
                prefix = "",
                -- prefix = "»",
                severity_limit = "Warning",
            },
            signs = vim.b[bufnr].show_signs == true,
            -- Increase diagnostic signs priority
            update_in_insert = true,
        })

    -- TODO: look into fixing this maybe
    -- if client.server_capabilities.documentSymbolProvider then
    --     navic.attach(client, bufnr)
    -- end

    if filetype ~= "lua" then
        mapper("n", "K", "vim.lsp.buf.hover()")
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
                ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                    signs = true,
                    virtual_text = {
                        prefix = "",
                    },
                    update_in_insert = true,
                }),
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
    ["cmake-language-server"] = function()
        if 1 == vim.fn.executable("cmake-language-server") then
            lspconfig.cmake.setup({
                on_attach = custom_attach,
                init_options = { buildDirectory = "build" },
            })
        end
    end,
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
            keyOrdering = false,
            schemaStore = {
                url = 'https://www.schemastore.org/api/json/catalog.json',
                enable = true,
            },
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
                        autoRequire = true,
                        callSnippet = "Replace",
                    },
                    format = {
                        enable = true,
                        defaultConfig = {
                            indent_style = 'space',
                            indent_size = '2',
                            max_line_length = '100',
                            trailing_table_separator = 'smart',
                        },
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
    vim.diagnostic.config({
        virtual_text = false,
        severity_sort = true,
        float = {
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }),
})
