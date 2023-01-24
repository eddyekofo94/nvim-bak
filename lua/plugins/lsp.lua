return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "sumneko_lua", "clangd", "bash-language-server", "rust_analyzer" },
      function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({})
      end,
    },
  },
}
