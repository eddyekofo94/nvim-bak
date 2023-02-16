vim.cmd("set termguicolors")
local utils = require("eekofo.utils")

local auto_formatters = {}

local python_autoformat = { "BufWritePre", "*.py", "lua vim.lsp.buf.formatting_sync(nil, 1000)" }
if O.python.autoformat then
    table.insert(auto_formatters, python_autoformat)
end

local javascript_autoformat = { "BufWritePre", "*.js", "lua vim.lsp.buf.formatting_sync(nil, 1000)" }
local javascriptreact_autoformat = { "BufWritePre", "*.jsx", "lua vim.lsp.buf.formatting_sync(nil, 1000)" }
if O.tsserver.autoformat then
    table.insert(auto_formatters, javascript_autoformat)
    table.insert(auto_formatters, javascriptreact_autoformat)
end

local lua_format = { "BufWritePre", "*.lua", "lua vim.lsp.buf.formatting_sync(nil, 1000)" }
if O.lua.autoformat then
    table.insert(auto_formatters, lua_format)
end
local json_format = { "BufWritePre", "*.json", "lua vim.lsp.buf.formatting_sync(nil, 1000)" }
if O.json.autoformat then
    table.insert(auto_formatters, json_format)
end

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})
-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "qf",
        "help",
        "man",
        "notify",
        "lspinfo",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "PlenaryTestPopup",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

utils.define_augroups({
    _general_settings = {
        { "TextYankPost", "*", "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 500})" },
        { "BufWinEnter", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
        { "BufRead", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
        { "BufNewFile", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
        { "VimLeavePre", "*", "set title set titleold=" },
    },
    _dashboard = {
        {
            "FileType",
            "dashboard",
            "setlocal nocursorline noswapfile synmaxcol& signcolumn=no norelativenumber nocursorcolumn nospell  nolist  nonumber bufhidden=wipe colorcolumn= foldcolumn=0 matchpairs= ",
        },
        { "FileType", "dashboard", "set showtabline=0 | autocmd BufLeave <buffer> set showtabline=2" },
    },
    _markdown = { { "FileType", "markdown", "setlocal wrap" }, { "FileType", "markdown", "setlocal spell" } },
    _buffer_bindings = {
        { "FileType", "dashboard", "nnoremap <silent> <buffer> q :q<CR>" },
        { "FileType", "lspinfo", "nnoremap <silent> <buffer> q :q<CR>" },
    },
    _auto_formatters = auto_formatters,
})
