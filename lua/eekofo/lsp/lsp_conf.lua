-- EDDY: Based to TJ's config -- reffer to that in the future
local lspconfig = require("lspconfig")
local navic = require("nvim-navic")

_ = require("lspkind").init()

local mapper = function(mode, key, result)
    vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. result .. "<CR>", { noremap = true, silent = true })
end
local custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

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
    -- INFO: to be removed since I believe I don't use this anymore
    require("lsp_signature").on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = { border = "single" },
        hint_enable = false, -- virtual hint enable
    })

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
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

    -- Rust is currently the only thing w/ inlay hints
    if filetype == "rust" then
        vim.cmd(
            [[autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request { ]]
                .. [[aligned = true, prefix = " » " ]]
                .. [[} ]]
        )
    end

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

---
-- Diagnostics
---
local signs_defined = {
    error_sign = "",
    warn_sign = "",
    hint_sign = "",
    infor_sign = "",
    code_action_icon = " ",
    rename_prompt_prefix = ">",
}
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = "",
    })
end

navic.setup({
    highlight = true,
})

sign({ name = "DiagnosticSignError", text = signs_defined.error_sign })
sign({ name = "DiagnosticSignWarn", text = signs_defined.warn_sign })
sign({ name = "DiagnosticSignHint", text = "⚑" })
sign({ name = "DiagnosticSignInfo", text = "" })

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

lspconfig.gopls.setup({
    on_attach = custom_attach,
    on_init = custom_init,
    capabilities = capabilities,
    cmd = { "gopls", "serve" },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            linksInHover = false,
            codelenses = {
                generate = true,
                gc_details = true,
                regenerate_cgo = true,
                tidy = true,
                upgrade_depdendency = true,
                vendor = true,
            },
            usePlaceholders = true,
        },
    },
})

if 1 == vim.fn.executable("cmake-language-server") then
    lspconfig.cmake.setup({
        cmd = { "cmake-language-server" },
        filetypes = { "cmake" },
        on_attach = custom_attach,
        init_options = { buildDirectory = "build" },
    })
end

lspconfig.bashls.setup({ on_attach = custom_attach })

-- yaml TODO: ensure that it works
lspconfig.yamlls.setup({ on_init = custom_init, on_attach = custom_attach })

-- lspconfig.vimls.setup({ on_init = custom_init, on_attach = custom_attach })

-- https://github.com/theia-ide/typescript-language-server
require("lspconfig").tsserver.setup({
    server = {
        on_init = custom_init,
        on_attach = custom_attach,
    },
})

-- Helps with the diagnostics error detection
require("lsp-colors").setup()

-- mapped to <space>lt -- this shows a list of diagnostics
require("eekofo.lsp.lsptrouble")

-- for completion
require("eekofo.lsp.cmp")

-- some lsp helps
--require("eekofo.lsp.lspsaga")
-- helps the lsp experience
require("eekofo.lsp.handlers")

return { on_attach = custom_attach, capabilities = capabilities, on_init = custom_init }
