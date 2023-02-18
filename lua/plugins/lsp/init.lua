 local lspconfig = require("lspconfig")
 local lsp_conf = require("plugins.lsp.lsp_conf")

 local neodev = require("neodev").setup({})
 local mason = require("mason").setup()
 local mason_lspconfig =  require("mason-lspconfig")

 require("mason-lspconfig").setup({
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
         "dockerls",
     },
 })

mason_lspconfig.setup_handlers({
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
     ["vimls"] = function()
         lspconfig.vimls.setup({
             on_init = lsp_conf.on_init,
             on_attach = lsp_conf.on_attach,
             capabilities = lsp_conf.capabilities,
         })
     end,
     ["bashls"] = function()
         lspconfig.bashls.setup({
             on_init = lsp_conf.on_init,
             on_attach = lsp_conf.on_attach,
             capabilities = lsp_conf.capabilities,
         })
     end,
     -- BUG: this seems to not be working
     ["cucumber_language_server"] = function()
         lspconfig.cucumber_language_server.setup({
             on_init = lsp_conf.on_init,
             on_attach = lsp_conf.on_attach,
             capabilities = lsp_conf.capabilities,
         })
     end,
     ["pylsp"] = function()
         lspconfig.pylsp.setup({
             on_init = lsp_conf.on_init,
             on_attach = lsp_conf.on_attach,
             capabilities = lsp_conf.capabilities,
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
             on_init = lsp_conf.on_init,
             on_attach = lsp_conf.on_attach,
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
             on_init = lsp_conf.on_init,
             on_attach = lsp_conf.on_attach,
             -- Required for lsp-status
             init_options = { clangdFileStatus = true },
             capabilities = lsp_conf.capabilities,
         })
     end,
     ["lua_ls"] = function()
         lspconfig.lua_ls.setup({
             on_init = lsp_conf.on_init,
             on_attach = lsp_conf.on_attach,
             capabilities = lsp_conf.capabilities,
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
         bufmap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
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

 --vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

 --vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

 -- Helps with the diagnostics error detection
 require("lsp-colors").setup()

 -- mapped to <space>lt -- this shows a list of diagnostics
 require("eekofo.lsp.lsptrouble")

 -- for completion
 require("eekofo.lsp.cmp")

 _ = require("lspkind").init()

 return { mason = mason, mason_config  = mason_config, neodev = neodev}
