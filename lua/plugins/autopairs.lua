return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    disable_filetype = { "oil", "TelescopePrompt", "vim" },
    check_ts = true,
    map_cr = true, -- send closing symbol to its own line
    ts_config = {
      lua = { "string" }, -- it will not add a pair on that treesitter node
    },
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
