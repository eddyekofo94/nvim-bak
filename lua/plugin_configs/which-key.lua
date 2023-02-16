require("which-key").setup({ plugins = { presets = { operators = false } } })
local Util = require("plugins.utils")

local wk = require("which-key")

local leader_mappings = {
    b = {
        name = "+buffer",
        d = { ":BufferDelete<cr>", "Buffer delete" },
        e = { ":BufferLineSortByExtension<cr>", "sort by lang" },
        p = { ":BufferLinePick<cr>", "Pick Buffer" },
        x = { ":%bd|e#|bd#<cr>", "close all but current" },
    },
    d = {
        name = "+diagnostics",
        n = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "diagnostics next" },
        p = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "diagnostics prev" },
    },
    g = {
        name = "+Git",
        a = { ":Gitsigns stage_hunk<cr>", "add hunk" },
        u = { ":Gitsigns undo_stage_hunk<cr>", "undo stage hunk" },
        r = { ":Gitsigns reset_hunk<cr>", "reset hunk" },
        R = { ":Gitsigns reset_buffer<cr>", "reset buffer" },
        p = { ":Gitsigns preview_hunk<cr>", "preview hunk" },
        b = { ":Gitsigns blame_line<cr>", "blame line" },
        B = { ":Gitsigns toggle_current_line_blame<cr>", "toggle blame line" },
    },
    l = {
        name = "+lsp",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "code action" },
        A = { "<cmd>lua vim.lsp.buf.range_code_action()<cr>", "selected action" },
        d = { ":Telescope diagnostics<cr>", "document diagnostics" },
        D = {
            ":Telescope lsp_workspace_diagnostics<cr>",
            "workspace diagnostics",
        },
        f = { "<cmd>lua vim.lsp.buf.format()<CR>", "format" },
        h = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "signature help" },
        I = { ":LspInfo<cr>", "lsp info" },
        v = { ":LspVirtualTextToggle<cr>", "lsp toggle virtual text" },
        --l = { ":Lspsaga lsp_finder<cr>", "lsp finder" },
        -- L = { ":Lspsaga show_line_diagnostics<cr>", "line_diagnostics" },
        O = { ":SymbolsOutline<cr>", "symbol outline" },
        p = { "<cmd>lua vim.diagnostic.open_float()<cr>", "preview definition" },
        q = { ":Telescope quickfix<cr>", "quickfix" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "rename" },
        t = { ":TroubleToggle<cr>", "trouble" },
        T = { ":LspTypeDefinition<cr>", "type defintion" }, -- TODO: fix this in the future
        x = { ":cclose<cr>", "close quickfix" },
        s = { ":Telescope lsp_document_symbols<cr>", "document symbols" },
        S = { ":Telescope lsp_workspace_symbols<cr>", "workspace symbols" },
    },
    s = {
        name = "search", -- optional group name
        ["."] = { ":Telescope filetypes<cr>", "filetypes" },
        b = { ":Telescope buffers<cr>", "buffers" },
        B = { ":Telescope git_branches<cr>", "git branches" },
        d = { ":Telescope lsp_document_diagnostics<cr>", "document_diagnostics" },
        D = {
            ":Telescope lsp_workspace_diagnostics<cr>",
            "workspace_diagnostics",
        },
        f = { ":Telescope frecency<cr>", "frecency" },
        h = { ":Telescope command_history<cr>", "history" },
        -- i = {":Telescope media_files<cr>", "media files"},
        m = { ":Telescope marks<cr>", "marks" },
        M = { ":Telescope man_pages<cr>", "man_pages" },
        o = { ":Telescope vim_options<cr>", "vim_options" },
        p = {
            ":lua require'telescope'.extensions.project.project{}<cr>",
            "projects",
        }, -- TODO: learn how to create projects
        s = { Util.telescope("live_grep"), "string" },
        T = { ":TodoTelescope<cr>", "TODO" },
        r = { ":Telescope registers<cr>", "registers" },
        w = { ":Telescope file_browser<cr>", "file browser" },
        u = { ":Telescope colorscheme<cr>", "colorschemes" },
        z = { ":Telescope zoxide list<cr>", "zoxide" },
    },
    S = {
        name = "+Session",
        d = { ":DisableAutoSave<cr>", "disable session" },
        f = { "<cmd>SearchSession<cr>", "find session" },
        s = { ":SaveSession<cr>", "save session" },
        l = { ":RestoreSession<cr>", "load Session" },
        x = { ":DeleteSession<cr>", "delete session" },
    },
    ["/"] = { ":CommentToggle<CR>", "comment" },
    ["\\"] = { "<cmd>Telescope pickers<cr>", "Searched History" },
    [":"] = { "<cmd>Telescope command_history<cr>", "Command History" },
    [" "] = { Util.telescope("files"), "Find File" },
    ["-"] = { ":split<CR>", "split horizontally" },
    ["="] = { "<C-w>=", "balance windows" },
    ["?"] = { ":NvimTreeFindFile<cr>", "find current file" },
    ["~"] = { ":NvimTreeRefresh<cr>", "refresh tree" },
    h = { ':let @/ = ""<cr>', "Clear Highlight" },
    H = { ":split", "Split bottom" },
    M = { ":Mason<cr>", "Mason" },
    f = { "<cmd>Format<cr>", "Format File" },
    F = { "<cmd>FormatWrite<cr>", "Format & Save File" },
    G = { "<cmd>LazyGit<cr>", "Lazygit" },
    e = { "Explorer" },
    o = {
        name = "Add line below",
        o = {
            ':<C-u>call append(line("."),   repeat([""], v:count1))<CR>',
            "inset line",
        },
    },
    O = {
        name = "Add line above",
        O = {
            ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>',
            "inset line",
        },
    },
    p = { Util.telescope("files", { cwd = false }), "Find File" },
    P = {
        "<cmd>:lua require'telescope'.extensions.project.project{}<cr>",
        "Find Project",
    },
    -- Telescope resume
    r = { "<cmd>Telescope resume<cr>", "Resume search" },
    R = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
    t = { "<cmd>rightbelow vsp | terminal<cr>", "terminal" },
    T = { "<cmd>TodoQuickFix<cr>", "Search TODO" },
    U = { "<cmd>UndotreeShow<cr>", "Undotree show" },
    v = { "<C-W>v", "Split Right" },
    w = { "<cmd>MaximizerToggle<CR>", "Max Window" },
    W = { "<C-W>q", "Close Window" },
    z = { ":ZenMode<cr>", "zen mode" },
}

local next_movement_mappings = {
    ["]"] = { name = "next", c = { "next git hunk" }, d = { "next diagnostic" } },
}

local prev_movement_mappings = {
    ["["] = { name = "prev", c = { "prev git hunk" }, d = { "prev diagnostic" } },
}

wk.register(leader_mappings, { prefix = "<leader>" })
wk.register(prev_movement_mappings, { prefix = "" })
wk.register(next_movement_mappings, { prefix = "" })
