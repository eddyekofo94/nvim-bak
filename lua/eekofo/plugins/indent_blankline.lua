-- TODO: move this to it's own file
vim.g.indent_blankline_char = '▏'
vim.g.indent_blankline_show_first_indent_level = true
vim.g.indent_blankline_filetype_exclude = {
    "startify", "dashboard", "dotooagenda", "log", "fugitive", "gitcommit",
    "packer", "vimwiki", "markdown", "json", "txt", "vista", "help", "todoist",
    "peekaboo", "git", "TelescopePrompt", "undotree", "flutterToolsOutline", ""
}

vim.g.indent_start_level = 1

vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
    "class", "function", "method", "^if", "if_statement", "while", "for",
    "with", "func_literal", "list_literal", "selector", "table", "while",
    "^block", "try", "except", "argument_list", "object", "dictionary"
}
vim.cmd("autocmd CursorMoved * IndentBlanklineRefresh")

