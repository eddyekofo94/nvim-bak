require "lspconfig".rust_analyzer.setup {
    cmd = {DATA_PATH .. "/lspinstall/rust/rust-analyzer"},
    on_attach = require "lsp".common_on_attach,
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
