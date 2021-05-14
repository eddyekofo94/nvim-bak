require("which-key").setup {}
local wk = require("which-key")

local mappings = {
    b = {
        name = "+buffer",
        p = {":BufferPick<cr>", "pick buffer"},
        d = {":BufferOrderByDirectory<cr>", "order by directory"},
        l = {":BufferOrderByLanguage<cr>", "order by language"}
    },
    d = {
        name = "+diagnostics",
        n = {":Lspsaga diagnostic_jump_next<cr>", "diagnostics next"},
        p = {":Lspsaga diagnostic_jump_prev<cr>", "diagnostics prev"}
    },
    g = {
        name = "+Git",
        s = {":Gitsigns stage_hunk<cr>", "stage hunk"},
        u = {":Gitsigns undo_stage_hunk<cr>", "undo stage hunk"},
        r = {":Gitsigns reset_hunk<cr>", "reset hunk"},
        R = {":Gitsigns reset_buffer<cr>", "reset buffer"},
        p = {":Gitsigns preview_hunk<cr>", "preview hunk"},
        b = {":Gitsigns blame_line<cr>", "blame line"}
    },
    l = {
        name = "+lsp",
        a = {":Lspsaga code_action<cr>", "code action"},
        A = {":Lspsaga range_code_action<cr>", "selected action"},
        d = {":Telescope lsp_document_diagnostics<cr>", "document diagnostics"},
        D = {":Telescope lsp_workspace_diagnostics<cr>", "workspace diagnostics"},
        f = {":LspFormatting", "format<cr>"},
        h = {":Lspsaga signature_help<cr>", "signature help"},
        I = {":LspInfo<cr>", "lsp info"},
        v = {":LspVirtualTextToggle<cr>", "lsp toggle virtual text"},
        l = {":Lspsaga lsp_finder<cr>", "lsp finder"},
        L = {":Lspsaga show_line_diagnostics<cr>", "line_diagnostics"},
        p = {":Lspsaga preview_definition<cr>", "preview definition"},
        q = {":Telescope quickfix<cr>", "quickfix"},
        r = {":Lspsaga rename<cr>", "rename"},
        t = {":LspTroubleToggle<cr>", "trouble"},
        T = {":LspTypeDefinition<cr>", "type defintion"},
        x = {":cclose<cr>", "close quickfix"},
        s = {":Telescope lsp_document_symbols<cr>", "document symbols"},
        S = {":Telescope lsp_workspace_symbols<cr>", "workspace symbols"}
    },
    s = {
        name = "search", -- optional group name
        b = {"<cmd>Telescope buffers<cr>", "Buffers"}, -- create a binding with label
        B = {"<cmd>Telescope git_branches<cr>", "Git Branches"}, -- create a binding with label
        f = {"<cmd>Telescope find_files<cr>", "Find File"}, -- create a binding with label
        r = {"<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap = false, buffer = 123}, -- additional options for creating the keymap
        s = {'<cmd>lua require("telescope").extensions.fzf_writer.staged_grep()<CR>', "String"},
        t = {"<cmd>Telescope filetypes<cr>", "Filetype"}, -- create a binding with label
        T = {"<cmd>TodoTelescope<cr>", "TODO"} -- just a label. don't create any mapping
    },
    S = {
        name = "+Session",
        s = {":SessionSave<cr>", "save session"},
        l = {":SessionLoad<cr>", "load Session"}
    },
    f = {"<cmd>Neoformat<cr>", "Format File"},
    G = {"<cmd>LazyGit<cr>", "lazygit"},
    E = {"<cmd>NvimTreeFindFile<cr>", "Find Current file"},
    p = {"<cmd>Telescope find_files<cr>", "Find File"},
    r = {"<cmd>Telescope oldfiles<cr>", "Recent File"},
    R = {"<cmd>RnvimrToggle<cr>", "Ranger"},
    v = {"<C-W>v", "split right"},
    w = {"<cmd>MaximizerToggle<CR>", "max window"}
}

wk.register(mappings, {prefix = "<leader>"})

return wk
