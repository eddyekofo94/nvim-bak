require("neoscroll").setup()
require("neoscroll.config").set_mappings({
	["<C-y>"] = { "scroll", { "-0.05", "false", "20" } },
	["<C-e>"] = { "scroll", { "0.05", "false", "20" } },
})
