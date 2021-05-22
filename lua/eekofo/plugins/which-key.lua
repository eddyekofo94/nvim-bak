require("which-key").setup {
    plugins = {
        presets = {
            operators = false
        }
    }
}

local wk = require("which-key")

local leader_mappings = {
    b = {
        name = "+buffer",
        d = {":BufferDelete<cr>", "Buffer delete"},
        f = {":BufferOrderByDirectory<cr>", "Order by Directory"},
        l = {":BufferCloseBuffersLeft<cr>", "Buffer close left"},
        t = {":BufferOrderByLanguage<cr>", "Order by Language"},
        p = {":BufferPick<cr>", "Pick Buffer"},
        r = {":BufferCloseBuffersRight<cr>", "Buffer close right"},
        x = {":BufferCloseAllButCurrent<cr>", "Close all but current"},
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
        f = {":LspFormatting<cr>", "format"},
        h = {":Lspsaga signature_help<cr>", "signature help"},
        I = {":LspInfo<cr>", "lsp info"},
        v = {":LspVirtualTextToggle<cr>", "lsp toggle virtual text"},
        l = {":Lspsaga lsp_finder<cr>", "lsp finder"},
        L = {":Lspsaga show_line_diagnostics<cr>", "line_diagnostics"},
        O = {":SymbolsOutline<cr>", "symbol outline"},
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
        ["."] = {":Telescope filetypes<cr>", "filetypes"},
        b = {":Telescope buffers<cr>", "buffers"},
        B = {":Telescope git_branches<cr>", "git branches"},
        d = {":Telescope lsp_document_diagnostics<cr>", "document_diagnostics"},
        D = {":Telescope lsp_workspace_diagnostics<cr>", "workspace_diagnostics"},
        f = {":Telescope find_files<cr>", "files"},
        h = {":Telescope command_history<cr>", "history"},
        i = {":Telescope media_files<cr>", "media files"},
        m = {":Telescope marks<cr>", "marks"},
        M = {":Telescope man_pages<cr>", "man_pages"},
        o = {":Telescope vim_options<cr>", "vim_options"},
        p = {":lua require'telescope'.extensions.project.project{}<cr>", "projects"}, -- TODO: learn how to create projects
        q = {":Telescope frecency<cr>", "frecency"},
        s = {':lua require("telescope").extensions.fzf_writer.staged_grep()<CR>', "string async"},
        S = {":Telescope live_grep<cr>", "string"},
        T = {":TodoTelescope<cr>", "TODO"},
        r = {":Telescope registers<cr>", "registers"},
        w = {":Telescope file_browser<cr>", "file browser"},
        u = {":Telescope colorscheme<cr>", "colorschemes"}
    },
    S = {
        name = "+Session",
        s = {":SessionSave<cr>", "save session"},
        l = {":SessionLoad<cr>", "load Session"}
    },
    ["/"] = "Comment",
    ["?"] = {":NvimTreeFindFile<cr>", "find current file"},
    ["H"] = "Disable Highlight",
    h = {':let @/ = ""<cr>', "Clear Highlight"},
    f = {"<cmd>Neoformat<cr>", "Format File"},
    G = {"<cmd>LazyGit<cr>", "Lazygit"},
    e = {"Explorer"},
    p = {"<cmd>Telescope find_files<cr>", "Find File"},
    P = {"<cmd>:lua require'telescope'.extensions.project.project{}<cr>", "Find Project"},
    r = {"<cmd>Telescope oldfiles<cr>", "Recent File"},
    R = {"<cmd>RnvimrToggle<cr>", "Ranger"},
    t = {"<cmd>rightbelow vsp | terminal<cr>", "terminal"},
    T = {"<cmd>TodoQuickFix<cr>", "Search TODO"},
    U = {"<cmd>UndotreeShow<cr>", "Undotree show"},
    v = {"<C-W>v", "Split Right"},
    w = {"<cmd>MaximizerToggle<CR>", "Max Window"}
}

local text_object_mappings = {
    o = {
        o = "Add line below"
    },
    O = {
        O = "Add line above"
    }
}

local next_movement_mappings = {
    ["]"] = {
        name = "next",
        c = {"next git hunk"},
        d = {"next diagnostic"}
    }
}

local prev_movement_mappings = {
    ["["] = {
        name = "prev",
        c = {"prev git hunk"},
        d = {"prev diagnostic"}
    }
}

wk.register(leader_mappings, {prefix = "<leader>"})
wk.register(text_object_mappings, {prefix = ""})
wk.register(prev_movement_mappings, {prefix = ""})
wk.register(next_movement_mappings, {prefix = ""})
