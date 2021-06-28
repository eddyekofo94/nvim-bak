-- better session management in neovim
require("auto-session").setup({
	log_level = "error",
	auto_session_enable_last_session = false,
	auto_session_enabled = true,
	auto_session_root_dir = vim.fn.stdpath("config") .. "/sessions/",
})

require("session-lens").setup({
	shorten_path = false,
	prompt_title = "Pick session",
	winblend = 4,
})

require("telescope").load_extension("session-lens")
