local gruvbox_colors = O.gruvbox_colors
local vi_mode = require("feline.providers.vi_mode")
local lsp = require("feline.providers.lsp")

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
	get_git_diff = function()
		return vim.b.gitsigns_status_dict ~= nil
	end,
	-- vim.b.gitsigns_status_dict["added"]
}

local check_lsp_active_client = function()
	local msg = "No Active Lsp"
	local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
	local clients = vim.lsp.get_active_clients()
	if next(clients) == nil then
		return msg
	end
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			return " LSP: " .. client.name
		end
	end
	return msg
end

local icons = {
	linux = " ",
	macos = " ",
	windows = " ",
}

local function file_osinfo()
	local os = vim.loop.os_uname().sysname
	local icon
	if os == "Linux" then
		icon = icons.linux
	elseif os == "Darwin" then
		icon = icons.macos
	else
		icon = icons.windows
	end
	return icon
end

local colors = {
	bg = gruvbox_colors.bg2,
	black = gruvbox_colors.bg2,
	yellow = "#d8a657",
	cyan = "#89b482",
	oceanblue = "#45707a",
	green = "#a9b665",
	orange = "#e78a4e",
	violet = "#d3869b",
	magenta = "#c14a4a",
	white = "#d4be98",
	fg = "#d4be98",
	skyblue = "#7daea3",
	red = "#ea6962",
}

local get_diag = function(str)
	local count = vim.lsp.diagnostic.get_count(0, str)
	return (count > 0) and " " .. count .. " " or ""
end

-- local get_diff = function(str)
-- 	local count = vim.b.gitsigns_status_dict[str]
-- 	return (count > 0) and " " .. count .. " " or ""
-- end

local vi_mode_provider = function()
	local mode_alias = {
		n = "NORMAL",
		no = "NORMAL",
		i = "INSERT",
		v = "VISUAL",
		V = "V-LINE",
		[""] = "V-BLOCK",
		c = "COMMAND",
		cv = "COMMAND",
		ce = "COMMAND",
		R = "REPLACE",
		Rv = "REPLACE",
		s = "SELECT",
		S = "SELECT",
		[""] = "SELECT",
		t = "TERMINAL",
	}
	-- return " " .. mode_alias[vim.fn.mode()] .. " "
	return "     "
end

local percentage_provider = function()
	local cursor = require("feline.providers.cursor")
	return " " .. cursor.line_percentage() .. " "
end

local vi_mode_hl = function()
	return {
		name = vi_mode.get_mode_highlight_name(),
		fg = "bg",
		bg = vi_mode.get_mode_color(),
		style = "bold",
	}
end

local vi_mode_hl_change_fg = function()
	return {
		name = vi_mode.get_mode_highlight_name(),
		fg = vi_mode.get_mode_color(),
		bg = "bg",
		style = "bold",
	}
end
-- local components = {
--     active = {},
--     inactive = {},
-- }
--
-- components.active[1] = {
--     fg = gruvbox_colors.fg,
--     bg = gruvbox_colors.bg4,
--     colors = colors,
--     vi_mode_colors = {
--         NORMAL = "cyan",
--         OP = "cyan",
--         INSERT = "white",
--         VISUAL = "yellow",
--         BLOCK = "green",
--         REPLACE = "yellow",
--         ["V-REPLACE"] = "yellow",
--         ENTER = "cyan",
--         MORE = "cyan",
--         SELECT = "magenta",
--         COMMAND = "orange",
--         SHELL = "red",
--         TERM = "red",
--         NONE = "orange",
--     },
--     {
--         provider = vi_mode_provider,
--         hl = vi_mode_hl,
--     },
--     {
--
--
--     }
-- }
--
require("feline").setup({
	fg = gruvbox_colors.fg,
	bg = gruvbox_colors.bg4,
	colors = colors,
	vi_mode_colors = {
		NORMAL = "cyan",
		OP = "cyan",
		INSERT = "white",
		VISUAL = "yellow",
		BLOCK = "green",
		REPLACE = "yellow",
		["V-REPLACE"] = "yellow",
		ENTER = "cyan",
		MORE = "cyan",
		SELECT = "magenta",
		COMMAND = "orange",
		SHELL = "red",
		TERM = "red",
		NONE = "orange",
	},
	components = {
		left = {
			active = {
				{
					provider = vi_mode_provider,
					hl = vi_mode_hl,
				},
				{
					provider = "file_info",
					left_sep = " ",
					right_sep = { str = "", hl = { fg = "black", bg = gruvbox_colors.bg4 } },
				},
				{
					provider = "position",
					hl = { fg = "violet", bg = "black" },
				},
				{ provider = "", hl = { fg = "black", bg = "bg" } },
				{
					provider = "git_branch",
					icon = "  ",
					right_sep = " ",
					enabled = conditions.check_git_workspace,
				},
				{ provider = "git_diff_added", hl = { fg = "green" } },
				{ provider = "git_diff_changed", hl = { fg = "yellow" } },
				{ provider = "git_diff_removed", hl = { fg = "red" } },
				{ provider = "", hl = { fg = "bg", bg = "black" } },
			},
			inactive = {
				{ provider = vi_mode_provider, hl = vi_mode_hl, right_sep = " " },
				{
					provider = "git_branch",
					icon = " ",
					right_sep = "  ",
					enabled = conditions.check_git_workspace,
				},
				{ provider = "file_info" },
				{ provider = "", hl = { fg = "bg", bg = "black" } },
			},
		},
		mid = {
			active = {
				{
					provider = check_lsp_active_client,
					hl = { fg = "fg", bg = gruvbox_colors.bg4 },
					left_sep = { str = "", hl = { fg = gruvbox_colors.bg4, bg = gruvbox_colors.bg2 } },
					right_sep = { str = "", hl = { fg = gruvbox_colors.bg4, bg = gruvbox_colors.bg2 } },
					enabled = conditions.hide_in_width,
				},
			},
			inactive = {},
		},
		right = {
			active = {
				{
					provider = function()
						return get_diag("Error")
					end,
					hl = { fg = "bg", bg = "red", style = "bold" },
					left_sep = { str = " ", hl = { fg = "red", bg = gruvbox_colors.bg2 } },
					right_sep = { str = "", hl = { fg = "yellow", bg = "red" } },
				},
				{
					provider = function()
						return get_diag("Warning")
					end,
					hl = { fg = "bg", bg = "yellow", style = "bold" },
					right_sep = { str = "", hl = { fg = "cyan", bg = "yellow" } },
				},
				{
					provider = function()
						return get_diag("Information")
					end,
					hl = { fg = "bg", bg = "cyan", style = "bold" },
					right_sep = { str = "", hl = { fg = "oceanblue", bg = "cyan" } },
				},
				{
					provider = function()
						return get_diag("Hint")
					end,
					hl = { fg = "bg", bg = "oceanblue", style = "bold" },
					right_sep = { str = "", hl = { fg = "bg", bg = "oceanblue" } },
				},
				{ provider = "file_type", left_sep = " ", enabled = conditions.hide_in_width },
				{
					provider = "file_encoding",
					left_sep = " ",
					enabled = conditions.hide_in_width,
				},
				{
					provider = file_osinfo,
					left_sep = " ",
					hl = {
						style = "bold",
					},
					enabled = conditions.hide_in_width,
				},
				{ provider = percentage_provider, hl = vi_mode_hl },
			},
			inactive = {},
		},
	},
	-- properties = {
	force_inactive = {
		filetypes = {
			"NvimTree",
			"packer",
			"dap-repl",
			"dapui_scopes",
			"dapui_stacks",
			"dapui_watches",
			"dapui_repl",
			"LspTrouble",
			"dashboard",
		},
		buftypes = { "terminal", "dashboard" },
		bufnames = {},
	},
	-- },
})
