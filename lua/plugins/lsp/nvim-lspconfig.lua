local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local keymap_set = require("utils").keymap_set
local navic = require("nvim-navic")

mason_lspconfig.setup({
  ensure_installed = {
    "eslint",
    "jsonls",
    "marksman",
    "lua_ls",
    "vimls",
    "rust_analyzer",
    "yamlls",
    "gopls",
    "pylsp",
    "clangd",
    "bashls",
    "sqlls",
    "cmake",
    "gopls",
    "glint",
    "dockerls",
  },
})

local mapper = function(mode, key, result, desc)
  vim.api.nvim_set_keymap(mode, key, "<cmd>lua " .. result .. "<CR>", { noremap = true, silent = true, desc = desc })
end
-- local mapper = require("utils")

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local signs_defined = O.icons

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
  mapper("n", "<space>dD", "vim.lsp.buf.declaration()", "declaration")
  mapper("n", "<space>di", "vim.lsp.buf.implementation()", "implementation")
  mapper("n", "gs", "vim.lsp.buf.signature_help()<cr>", "signature help")
  mapper("n", "<space>dR", "vim.lsp.buf.references()", "references")
  mapper("n", "<space>dc", "vim.lsp.buf.incoming_calls()", "incoming calls")
  mapper("n", "<space>da", "vim.diagnostic.setloclist()", "setloclist")
  mapper("n", "<leader>lr", "vim.lsp.buf.rename()<cr>", "rename")
  keymap_set("n", "<c-]>", "<Cmd>vsp | lua vim.lsp.buf.definition()<CR>", "definition")

  -- INFO: this is set on Lspsaga
  -- mapper('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
  -- mapper("n", "K", "vim.lsp.buf.hover()", "hover")
  -- mapper('n', '<leader>dl', 'vim.diagnostic.open_float()<cr>', "open float")
  -- mapper("n", "[d", "vim.diagnostic.goto_prev()")
  -- mapper("n", "]d", "vim.diagnostic.goto_next()")

  sign({ name = "DiagnosticSignError", text = signs_defined.small_dot })
  sign({ name = "DiagnosticSignWarn", text = signs_defined.small_dot })
  sign({ name = "DiagnosticSignHint", text = signs_defined.small_dot })
  sign({ name = "DiagnosticSignInfo", text = signs_defined.small_dot })

  local filetype = vim.api.nvim_buf_get_name(bufnr)

  local format_code
  if client.supports_method("textDocument/formatting") then
    format_code = "<cmd>lua require('conform').format()<cr>"
  elseif filetype == "go" then
    format_code = "<cmd>lua require('go.format').goimport()<CR>"
  end

  keymap_set("n", "<leader>f", format_code, { desc = "Format" })

  -- Only highlight if compatible with the language
  if client.server_capabilities.documentHighlightProvider then
    vim.cmd([[
            hi! LspReferenceRead cterm=bold ctermbg=None guibg=#45475a guifg=None
            hi! LspReferenceText cterm=bold ctermbg=None guibg=#45475a guifg=None
            hi! LspReferenceWrite cterm=bold ctermbg=None guibg=#45475a guifg=None
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
    vim.api.nvim_buf_set_keymap(0, "n", "<s-f>", "<cmd>ClangdSwitchSourceHeader<CR>", { noremap = true, silent = true })
  end

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- Hide/Show virtual text
    virtual_text = {
      prefix = "",
      severity_limit = "Warning",
      spacing = 4,
    },
    signs = true,
    update_in_insert = true,
  })

  vim.lsp.handlers["workspace/diagnostic/refresh"] = function(_, _, ctx)
    local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id, _)
    local bufnr = vim.api.nvim_get_current_buf()
    vim.diagnostic.reset(ns, bufnr)
    return true
  end

  -- TODO: look into fixing this maybe
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint(bufnr, true)
  end

  -- if filetype ~= "lua" then
  --     mapper("n", "K", "vim.lsp.buf.hover()")
  -- end

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()

-- Completion configuration
vim.tbl_deep_extend("force", updated_capabilities, require("cmp_nvim_lsp").default_capabilities())
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }

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
      capabilities = updated_capabilities,
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
      capabilities = updated_capabilities,
    })
  end,
  ["cmake"] = function()
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
      capabilities = updated_capabilities,
      filetypes = { "sh", "zsh", "bash", ".zshrc" },
    })
  end,
  -- BUG: this seems to not be working
  ["cucumber_language_server"] = function()
    lspconfig.cucumber_language_server.setup({
      on_init = custom_init,
      on_attach = custom_attach,
      capabilities = updated_capabilities,
    })
  end,
  ["pylsp"] = function()
    lspconfig.pylsp.setup({
      on_init = custom_init,
      on_attach = custom_attach,
      capabilities = updated_capabilities,
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
        url = "https://www.schemastore.org/api/json/catalog.json",
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
        "--all-scopes-completion",
        "--completion-style=detailed",
        "--clang-tidy",
        "--cross-file-rename",
        "--fallback-style=Google",
        "--header-insertion=iwyu",
      },
      on_init = custom_init,
      on_attach = custom_attach,
      capabilities = updated_capabilities,
      init_options = {
        clangdFileStatus = true,
      },
    })
  end,
  ["gopls"] = function()
    -- local go_cfg = require("go.lsp").config() -- config() return the go.nvim gopls setup

    -- lspconfig.gopls.setup(go_cfg)
    lspconfig.gopls.setup({
      on_init = custom_init,
      on_attach = custom_attach,
      capabilities = updated_capabilities,
      analyses = {
        shadow = true,
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      experimentalPostfixCompletions = true,
      gofumpt = true,
      setting = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
        },
      },
      usePlaceholders = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      staticcheck = true,
    })
  end,
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup({
      on_init = custom_init,
      on_attach = custom_attach,
      capabilities = updated_capabilities,
      settings = {
        Lua = {
          completion = {
            autoRequire = true,
            callSnippet = "Replace",
          },
          format = {
            enable = true,
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
              max_line_length = "100",
              trailing_table_separator = "smart",
            },
          },
          hint = {
            enable = true,
            arrayIndex = "enable",
            setType = true,
          },
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim", "use" },
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

local has_metals = pcall(require, "metals")
if has_metals then
  local metals_config = require("metals").bare_config()
  metals_config.on_attach = custom_attach

  -- Example of settings
  metals_config.settings = {
    showImplicitArguments = true,
    excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
  }

  -- Autocmd that will actually be in charging of starting the whole thing
  local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    -- NOTE: You may or may not want java included here. You will need it if you
    -- want basic Java support but it may also conflict if you are using
    -- something like nvim-jdtls which also works on a java filetype autocmd.
    pattern = { "scala", "sbt", "java" },
    callback = function()
      require("metals").initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
  })
end
