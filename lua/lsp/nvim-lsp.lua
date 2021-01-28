-- EDDY: Based to TJ's config -- reffer to that in the future
local lspconfig = require("lspconfig")
local lsp_status = require("lsp-status")
local completion = require("completion")

lsp_status.register_progress()

local mapper = function(mode, key, result)
    vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. result .. "<CR>", {noremap = true, silent = true})
end

local custom_attach = function(client)
    if client.config.flags then
        client.config.flags.allow_incremental_sync = true
    end

    completion.on_attach(client)

    -- set up mappings (only apply when LSP client attached)
    mapper("n", "K", "vim.lsp.buf.hover()")
    mapper("n", "gD", "vim.lsp.buf.definition()")
    mapper("n", "gi", "vim.lsp.buf.implementation()")
    mapper("n", "<C-k>", "vim.lsp.buf.signature_help()")
    mapper("n", "<c-]>", "vim.lsp.buf.definition()")
    mapper("n", "gR", "vim.lsp.buf.references()")
    mapper("n", "gr", "vim.lsp.buf.rename()")
    mapper("n", "H", "vim.lsp.buf.code_action()")
    mapper("n", "gin", "vim.lsp.buf.incoming_calls()")
    mapper("n", "<space>dn", "vim.lsp.diagnostic.goto_next()")
    mapper("n", "<space>dp", "vim.lsp.diagnostic.goto_prev()")
    mapper("n", "<space>da", "vim.lsp.diagnostic.set_loclist()")

    -- Diagnostic text colors
    vim.cmd [[ hi link LspDiagnosticsDefaultError ErrorMsg ]]
    vim.cmd [[ hi link LspDiagnosticsDefaultWarning WarningMsg ]]
    vim.cmd [[ hi link LspDiagnosticsDefaultInformation Tooltip ]]
    vim.cmd [[ hi link LspDiagnosticsDefaultHint Tooltip ]]

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
        hi LspReferenceRead cterm=bold ctermbg=None guibg=None guifg=LightYellow
        hi LspReferenceText cterm=bold ctermbg=None guibg=None guifg=LightYellow
        hi LspReferenceWrite cterm=bold ctermbg=None guibg=None guifg=LightYellow
        augroup lsp_document_highlight
          autocmd!
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
            false
        )
    end
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

    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
end

lspconfig.clangd.setup(
    {
        cmd = {
            "clangd",
            "--background-index",
            "--suggest-missing-includes",
            "--clang-tidy",
            "--header-insertion=iwyu"
        },
        on_attach = custom_attach,
        -- Required for lsp-status
        init_options = {
            clangdFileStatus = true
        },
        handlers = lsp_status.extensions.clangd.setup(),
        capabilities = lsp_status.capabilities
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

-- TODO: Fix the lua setup
require("nlua.lsp.nvim").setup(
    require("lspconfig"),
    {
        on_attach = custom_attach
        -- Include globals you want to tell the LSP are real :)
    }
)
-- bash TODO: ensure that it works, I don't don't think it works
lspconfig.bashls.setup {on_attach = custom_attach}

-- yaml TODO: ensure that it works
lspconfig.yamlls.setup {on_attach = custom_attach}

lspconfig.vimls.setup {
    on_attach = custom_attach
}
