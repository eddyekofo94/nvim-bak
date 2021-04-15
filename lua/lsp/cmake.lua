require "lspconfig".cmake.setup(
    {
        cmd = {"cmake-language-server"},
        filetypes = {"cmake"},
        on_attach = require "lsp".common_on_attach,
        init_options = {
            buildDirectory = "build/"
        }
    }
)
