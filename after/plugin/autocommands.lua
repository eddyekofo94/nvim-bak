vim.cmd("set termguicolors")
local utils = require("utils")
local fn = vim.fn

local get_size = function()
    return fn.getfsize(fn.expand("%")) > 512 * 1024
end

-- TODO: work on detecting large files
-- vim.api.nvim_create_autocmd({"BufWritePre", "FileReadPre"}, )

local aug = vim.api.nvim_create_augroup("buf_large", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
    callback = function()
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
        if ok and stats and (stats.size > 1000000) then
            vim.b.large_buf = true
            vim.opt_local.syntax = "off"
            vim.opt_local.syntax = "clear"
            vim.opt_local.filetype = "off"
            vim.opt_local.foldmethod = "manual"
            vim.opt_local.spell = false
        else
            vim.b.large_buf = false
        end
    end,
    group = aug,
    pattern = "*",
})

-- TODO: look into converting this to lua
-- function! MaxLineChars()
--     let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
-- endfunction
-- augroup MAX_CHARS_COLUMN
--     autocmd!
--     autocmd FileType,BufWinEnter cpp,h,hpp,cxx,cs,fish,shell,bash,go,rust,typescript,java,php,lua,javascript :call MaxLineChars()
--     autocmd BufLeave,BufDelete * :call clearmatches()
-- augroup end

-- vim.api.nvim_create_autocmd({ "BufWinEnter", "FileReadPre" }, {
--     callback = function()
--         return fn.
--     end,
-- })

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

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
        -- {
        -- "FileType,BufWinEnter",
        -- "cpp,h,hpp,cxx,cs,fish,shell,bash,go,rust,typescript,java,php,lua,javascript",
        -- ":call MaxLineChars()",
        -- },
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
})
