vim.cmd("set termguicolors")
local utils = require("utils")

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
-- General Settings
local general = augroup("General Settings", { clear = true })
-- local file_types = { "cpp","h","hpp","cxx",cs,fish,shell,bash,go,rust,typescript,java,php,lua,javascript" }
-- local file_types = { "go", "lua" }

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

autocmd("FileType", {
    pattern = { "c", "cpp", "py", "java", "cs" },
    callback = function()
        vim.bo.shiftwidth = 4
    end,
    group = general,
    desc = "Set shiftwidth to 4 in these filetypes",
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

-- REFACTOR: this needs to be worked on and improved upon.
-- autocmd(
--     "BufWinEnter", {
--         group = general,
--         pattern = { "lua", "go" },
--         callback = function(_)
--             -- vim.cmd([[let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)]])
--             vim.cmd([[
--                 function! MaxLineChars()
--                     let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
--                 endfunction
--             ]])
--             vim.api.nvim_call_function("MaxLineChars", _)
--         end,
--         desc = "Error hl >80",
--     }
-- )

-- NOTE: should restore cursor position on the last one
autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- close some filetypes with <q>
autocmd("FileType", {
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

local ignore_filetypes = { 'neo-tree' }
local ignore_buftypes = { 'nofile', 'prompt', 'popup' }

local augroup =
    vim.api.nvim_create_augroup('FocusDisable', { clear = true })

autocmd('WinEnter', {
    group = augroup,
    callback = function(_)
        if vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
        then
            vim.w.focus_disable = true
        else
            vim.w.focus_disable = false
        end
    end,
    desc = 'Disable focus autoresize for BufType',
})

autocmd('FileType', {
    group = augroup,
    callback = function(_)
        if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
            vim.w.focus_disable = true
        else
            vim.w.focus_disable = false
        end
    end,
    desc = 'Disable focus autoresize for FileType',
})

utils.define_augroups({
    _general_settings = {
        -- Highlight on yank
        { "TextYankPost", "*",
            "lua vim.highlight.on_yank{higroup = 'HighlightedyankRegion', timeout = 500}", },

        -- { "BufWinEnter", file_types, "" },
        { "BufWinEnter", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
        { "BufRead",     "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
        { "BufNewFile",  "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
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
    _markdown = { { "FileType", "markdown", "setlocal wrap" },
        { "FileType", "markdown", "setlocal spell" }, },
    _buffer_bindings = {
        { "FileType", "dashboard", "nnoremap <silent> <buffer> q :q<CR>" },
        { "FileType", "lspinfo",   "nnoremap <silent> <buffer> q :q<CR>" },
        { "FileType", "qf",        "nnoremap <silent> <buffer> q :q<CR>" },
    },
})
