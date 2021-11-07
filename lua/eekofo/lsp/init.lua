-- EDDY: Based to TJ's config -- reffer to that in the future
local lspconfig = require("lspconfig")
local colors = O.gruvbox_colors

_ = require("lspkind").init()

local mapper = function(mode, key, result)
	vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. result .. "<CR>", { noremap = true, silent = true })
end
local custom_init = function(client)
	client.config.flags = client.config.flags or {}
	client.config.flags.allow_incremental_sync = true
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local custom_attach = function(client)
	if client.config.flags then
		client.config.flags.allow_incremental_sync = true
	end

	-- set up mappings (only apply when LSP client attached)
	mapper("n", "<space>dD", "vim.lsp.buf.declaration()")
	mapper("n", "<space>di", "vim.lsp.buf.implementation()")
	mapper("n", "<c-]>", "vim.lsp.buf.definition()")
	mapper("n", "<space>dR", "vim.lsp.buf.references()")
	mapper("n", "<space>dR", "vim.lsp.buf.references()")
	mapper("n", "H", "vim.lsp.buf.code_action()")
	mapper("n", "<space>dc", "vim.lsp.buf.incoming_calls()")
	mapper("n", "<space>da", "vim.lsp.diagnostic.set_loclist()")
	mapper("n", "[d", "vim.lsp.diagnostic.goto_prev()")
	mapper("n", "]d", "vim.lsp.diagnostic.goto_next()")

	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = { "documentation", "detail", "additionalTextEdits" },
	}

	-- Setup lspconfig.
	capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
	-- NOTE: This enables highlighting, might need to look at removing the popup
	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
	    hi LspReferenceRead cterm=bold ctermbg=None guibg=#3c3836 guifg=None
	    hi LspReferenceText cterm=bold ctermbg=None guibg=#3c3836 guifg=None
	    hi LspReferenceWrite cterm=bold ctermbg=None guibg=#3c3836 guifg=None
	    augroup lsp_document_highlight
	      autocmd!
	      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
	      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
	    augroup END
	  ]],
			false
		)
	end
	require("lsp_signature").on_attach({
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		handler_opts = { border = "single" },
		hint_enable = false, -- virtual hint enable
	})

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
		-- Hide/Show virtual text
		virtual_text = {
			prefix = "",
			severity_limit = "Warning",
		},
		-- Increase diagnostic signs priority
		signs = { priority = 9999 },
		update_in_insert = true,
	})

	local filetype = vim.api.nvim_buf_get_option(0, "filetype")

	-- Rust is currently the only thing w/ inlay hints
	if filetype == "rust" then
		vim.cmd(
			[[autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request { ]]
				.. [[aligned = true, prefix = " » " ]]
				.. [[} ]]
		)
	end
	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		mapper("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>")
	elseif client.resolved_capabilities.document_range_formatting then
		mapper("n", "<leader>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>")
	end
	if vim.tbl_contains({ "go", "rust" }, filetype) then
		vim.cmd([[autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()]])
	end

	if filetype ~= "lua" then
		mapper("n", "K", "vim.lsp.buf.hover()")
	end
	if filetype == "cpp" then
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			"<s-f>",
			"<cmd>ClangdSwitchSourceHeader<CR>",
			{ noremap = true, silent = true }
		)
	end

	vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
end

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
	"   (Text) ",
	"   (Method)",
	"   (Function)",
	"   (Constructor)",
	" ﴲ  (Field)",
	"[] (Variable)",
	"   (Class)",
	" ﰮ  (Interface)",
	"   (Module)",
	" 襁 (Property)",
	"   (Unit)",
	"   (Value)",
	" 練 (Enum)",
	"   (Keyword)",
	" ﬌  (Snippet)",
	"   (Color)",
	"   (File)",
	"   (Reference)",
	"   (Folder)",
	"   (EnumMember)",
	" ﲀ  (Constant)",
	" ﳤ  (Struct)",
	"   (Event)",
	"   (Operator)",
	"   (TypeParameter)",
}

lspconfig.clangd.setup({
	cmd = {
		"clangd",
		"--background-index",
		"--suggest-missing-includes",
		"--clang-tidy",
		"--header-insertion=iwyu",
	},
	on_init = custom_init,
	on_attach = custom_attach,
	-- Required for lsp-status
	init_options = { clangdFileStatus = true },
	capabilities = capabilities,
})

lspconfig.rust_analyzer.setup({
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	on_attach = custom_attach,
	capabilities = capabilities,
	handlers = {
		["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			signs = true,
			virtual_text = {
				prefix = "",
			},
			update_in_insert = true,
		}),
	},
})

if 1 == vim.fn.executable("cmake-language-server") then
	lspconfig.cmake.setup({
		cmd = { "cmake-language-server" },
		filetypes = { "cmake" },
		on_attach = custom_attach,
		init_options = { buildDirectory = "build" },
	})
end
require("nlua.lsp.nvim").setup(lspconfig, {
	on_init = custom_init,
	on_attach = custom_attach,
})

lspconfig.bashls.setup({ on_attach = custom_attach })

-- yaml TODO: ensure that it works
lspconfig.yamlls.setup({ on_init = custom_init, on_attach = custom_attach })

lspconfig.vimls.setup({ on_init = custom_init, on_attach = custom_attach })

lspconfig.pyright.setup({
	on_init = custom_init,
	on_attach = custom_attach,
})

-- Helps with the diagnostics error detection
require("lsp-colors").setup()

-- mapped to <space>lt -- this shows a list of diagnostics
require("eekofo.lsp.lsptrouble")

-- for completion
require("eekofo.lsp.cmp")

-- some lsp helps
require("eekofo.lsp.lspsaga")
-- helps the lsp experience
require("eekofo.lsp.handlers")

return { on_attach = custom_attach, capabilities = capabilities }
