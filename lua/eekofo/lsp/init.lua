local lspconfig = require("lspconfig")
local lsp_conf = require("eekofo.lsp.lsp_conf")

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "sumneko_lua",
        "rust_analyzer",
        "yamlls",
        "pyright",
        "dockerls",
        "clangd",
        "bashls",
        "sqlls",
        "dockerls",
    },
})

require("mason-lspconfig").setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({})
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    ["rust_analyzer"] = function()
        require("rust-tools").setup({})
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
            on_init = lsp_conf.on_init,
            on_attach = lsp_conf.on_attach,
            -- Required for lsp-status
            init_options = { clangdFileStatus = true },
            capabilities = lsp_conf.capabilities,
        })
    end,
    ["sumneko_lua"] = function()
        lspconfig.sumneko_lua.setup({
            on_init = lsp_conf.on_init,
            on_attach = lsp_conf.on_attach,
            capabilities = lsp_conf.capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
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
        bufmap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
        bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
        bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
        bufmap("x", "<F4>", "<cmd>lua vim.lsp.buf.range_code_action()<cr>")
        bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
        bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
        bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
    end,
})


_ = require("lspkind").init()

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

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

-- Helps with the diagnostics error detection
require("lsp-colors").setup()

-- mapped to <space>lt -- this shows a list of diagnostics
require("eekofo.lsp.lsptrouble")

-- for completion
require("eekofo.lsp.cmp")

_ = require("lspkind").init()
