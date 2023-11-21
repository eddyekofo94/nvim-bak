local set = require("utils").keymap_set
local nxo = require("utils").nxo

return {
  "chrisgrieser/nvim-spider",
  opts = {
    skipInsignificantPunctuation = false,
  },
  keys = { "w", "e", "b", "ge" },
  config = function()
    set(nxo, "w", "<cmd>lua require('spider').motion('w')<CR>", "Spider-w")
    set(nxo, "e", "<cmd>lua require('spider').motion('e')<CR>", "Spider-e")
    set(nxo, "b", "<cmd>lua require('spider').motion('b')<CR>", "Spider-b")
    set(nxo, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })
  end,
}
