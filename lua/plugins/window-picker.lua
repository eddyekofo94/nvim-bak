local colors = O.catppuccin_colors

local opts = {
	autoselect_one = false,
	include_current_win = true,
	filter_rules = {
		bo = {
			filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },
			buftype = { "terminal" },
		},
	},
	selection_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
	use_winbar = "always",
	fg_color = colors.text.hex,
	current_win_hl_color = colors.yellow.hex,
	other_win_hl_color = colors.mauve.hex,
}

return {
	"s1n7ax/nvim-window-picker",
	version = "v1.*",
	opts = opts,
	cmd = "Neotree",
}
