local catpuccin = require("catppuccin.groups.integrations.feline")

--catpuccin.setup()
require('feline').winbar.setup()
require("feline").setup({
    components = catpuccin.get()
})
