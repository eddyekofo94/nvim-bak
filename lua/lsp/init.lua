-- EDDY: Based to TJ's config -- reffer to that in the future
local lspconfig = require("lspconfig")

_ = require("lspkind").init()

local mapper = function(mode, key, result)
    vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. result .. "<CR>", {noremap = true, silent = true})
end

local custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

local nvim_status = require("lsp-status")

local custom_attach = function(client)
    if client.config.flags then
        client.config.flags.allow_incremental_sync = true
    end

    nvim_status.on_attach(client)
    -- set up mappings (only apply when LSP client attached)
    mapper("n", "<space>dD", "vim.lsp.buf.definition()")
    mapper("n", "<space>di", "vim.lsp.buf.implementation()")
    mapper("n", "<c-]>", "vim.lsp.buf.definition()")
    mapper("n", "<space>dR", "vim.lsp.buf.references()")
    mapper("n", "<space>dc", "vim.lsp.buf.incoming_calls()")
    mapper("n", "<space>da", "vim.lsp.diagnostic.set_loclist()")

    -- auto format
    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_command [[augroup Format]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api.nvim_command [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
        vim.api.nvim_command [[augroup END]]
    end
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
        hi LspReferenceRead cterm=bold ctermbg=None guibg=None guifg=LightYellow
        hi LspReferenceText cterm=bold ctermbg=None guibg=None guifg=LightGreen
        hi LspReferenceWrite cterm=bold ctermbg=None guibg=None guifg=Pink
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
        vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            underline = true,
            -- Hide virtual text
            virtual_text = false,
            -- Increase diagnostic signs priority
            signs = {
                priority = 9999
            },
            update_in_insert = true
        }
    )

    local filetype = vim.api.nvim_buf_get_option(0, "filetype")

    -- Rust is currently the only thing w/ inlay hints
    if filetype == "rust" then
        vim.cmd(
            [[autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request { ]] ..
                [[aligned = true, prefix = " » " ]] .. [[} ]]
        )
    end

    if vim.tbl_contains({"go", "rust"}, filetype) then
        vim.cmd [[autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()]]
    end

    if filetype ~= "lua" then
        mapper("n", "K", "vim.lsp.buf.hover()")
    end

    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.codeLens = {
    dynamicRegistration = false
}

updated_capabilities = vim.tbl_extend("keep", updated_capabilities, nvim_status.capabilities)

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ",
    "   (Method)",
    "   (Function)",
    "   (Constructor)",
    " ﴲ  (Field)",
    "[] (Variable)",
    "   (Class)",
    " ﰮ  (Interface)",
    "   (Module)",
    " 襁 (Property)",
    "   (Unit)",
    "   (Value)",
    " 練 (Enum)",
    "   (Keyword)",
    " ﬌  (Snippet)",
    "   (Color)",
    "   (File)",
    "   (Reference)",
    "   (Folder)",
    "   (EnumMember)",
    " ﲀ  (Constant)",
    " ﳤ  (Struct)",
    "   (Event)",
    "   (Operator)",
    "   (TypeParameter)"
}

lspconfig.clangd.setup(
    {
        cmd = {
            "clangd",
            "--background-index",
            "--suggest-missing-includes",
            "--clang-tidy",
            "--header-insertion=iwyu"
        },
        on_init = custom_init,
        on_attach = custom_attach,
        -- Required for lsp-status
        init_options = {
            clangdFileStatus = true
        },
        handlers = nvim_status.extensions.clangd.setup(),
        capabilities = nvim_status.capabilities
    }
)

lspconfig.rust_analyzer.setup(
    {
        cmd = {"rust-analyzer"},
        filetypes = {"rust"},
        on_attach = custom_attach,
        handlers = {
            ["textDocument/publishDiagnostics"] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics,
                {
                    signs = true,
                    virtual_text = true,
                    update_in_insert = true
                }
            )
        }
    }
)

lspconfig.cmake.setup(
    {
        cmd = {"cmake-language-server"},
        filetypes = {"cmake"},
        on_attach = custom_attach,
        init_options = {
            buildDirectory = "build/"
        }
    }
)

require("nlua.lsp.nvim").setup(
    lspconfig,
    {
        on_init = custom_init,
        on_attach = custom_attach
    }
)

lspconfig.bashls.setup {on_attach = custom_attach}

-- yaml TODO: ensure that it works
lspconfig.yamlls.setup {
    on_init = custom_init,
    on_attach = custom_attach
}

lspconfig.vimls.setup {
    on_init = custom_init,
    on_attach = custom_attach
}

require("lsp-colors").setup(
    {
        Error = "#db4b4b",
        Warning = "#e0af68",
        Information = "#0db9d7",
        Hint = "#10B981"
    }
)
require("trouble").setup {}
require("lsp.compe")
require("lsp.lspsaga")
require("handlers")
require("status").activate()
