return {
  "SmiteshP/nvim-navic",
  config = function()
    require("nvim-navic").setup({
      highlight = true,
      click = true,
      lsp = {
        auto_attach = true,
        preference = nil,
      },
    })
    -- This is where I have navic all setup
    -- require("winbar")
    -- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
  end,
}
