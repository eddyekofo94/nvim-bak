-- EDDY: Based to TJ's config -- reffer to that in the future
local lspconfig = require('lspconfig')
local nvim_status = require('lsp-status')
local completion = require('completion')

local mapper = function(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. result .. "<CR>", {noremap = true, silent = true})
end

local custom_attach = function(client)

  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end

  completion.on_attach(client)

    -- set up mappings (only apply when LSP client attached)
    mapper("n" , "K"         , "vim.lsp.buf.hover()")
    mapper("n" , "<c-]>"     , "vim.lsp.buf.definition()")
    mapper("n" , "gR"        , "vim.lsp.buf.references()")
    mapper("n" , "gr"        , "vim.lsp.buf.rename()")
    mapper("n" , "H"         , "vim.lsp.buf.code_action()")
    mapper("n" , "gin"       , "vim.lsp.buf.incoming_calls()")
    mapper("n" , "<space>dn" , "vim.lsp.diagnostic.goto_next()")
    mapper("n" , "<space>dp" , "vim.lsp.diagnostic.goto_prev()")
    mapper("n" , "<space>da" , "vim.lsp.diagnostic.set_loclist()")


    -- Diagnostic text colors
    vim.cmd [[ hi link LspDiagnosticsDefaultError WarningMsg ]]
    vim.cmd [[ hi link LspDiagnosticsDefaultWarning WarningMsg ]]
    vim.cmd [[ hi link LspDiagnosticsDefaultInformation NonText ]]
    vim.cmd [[ hi link LspDiagnosticsDefaultHint NonText ]]

    vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
end

lspconfig.clangd.setup({
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu",
  },
  on_attach = custom_attach,

  -- Required for lsp-status
  init_options = {
     clangdFileStatus = true
  },
  handlers = nvim_status.extensions.clangd.setup(),
  capabilities = nvim_status.capabilities,
})

-- TODO: Fix the lua setup
-- require('nlua.lsp.nvim').setup(require('lspconfig'), {
  -- on_attach = custom_nvim_lspconfig_attach,

  -- Include globals you want to tell the LSP are real :)
  -- globals = {
    -- Colorbuddy
    -- "Color", "c", "Group", "g", "s",
  -- }
-- })
-- bash TODO: ensure that it works, I don't don't think it works
lspconfig.bashls.setup{on_attach=custom_attach}

-- yaml TODO: ensure that it works
lspconfig.yamlls.setup{on_attach=custom_attach}

-- It works, TODO: remove when fully confinced
lspconfig.vimls.setup {
  on_attach = custom_attach,
}
