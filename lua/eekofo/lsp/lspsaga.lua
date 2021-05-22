local saga = require "lspsaga"

-- add your config value here
-- default value
-- error_sign = '',
-- warn_sign = '',
-- hint_sign = '',
-- infor_sign = '',
-- code_action_icon = ' ',
-- finder_definition_icon = '  ',
-- finder_reference_icon = '  ',
-- definition_preview_icon = '  '
-- 1: thin border | 2: rounded border | 3: thick border
-- border_style = 1

local mapper = function(mode, key, result)
    vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

local opts = {
    error_sign = "",
    warn_sign = "",
    hint_sign = "",
    infor_sign = "",
    code_action_icon = " ",
    rename_prompt_prefix = ">"
}

vim.lsp.handlers["textDocument/hover"] = require("lspsaga.hover").handler

mapper("n", "K", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>")
mapper("n", "H", "<cmd>lua require'lspsaga.codeaction'.code_action()<CR>") --
mapper("n", "gs", "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>")
mapper("n", "gr", "<cmd>lua require('lspsaga.rename').rename()<CR>")
mapper("n", "gd", "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>")
mapper("n", "gh", "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>") -- search all files, respecting .gitignore if one exists

mapper("n", "<c-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")
mapper("n", "<c-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")

vim.cmd [[autocmd CursorHold * lua require'lspsaga.diagnostic'.show_cursor_diagnostics()]]

saga.init_lsp_saga(opts)
