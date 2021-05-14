require("which-key").setup {}
require("which-key").setup {
    plugins = {
        presets = {
            operators = false
        }
    }
}
local wk = require("which-key")

local mappings = {
    b = {
        name = "+buffer",
        p = {":BufferPick<cr>", "pick buffer"},
        d = {":BufferOrderByDirectory<cr>", "order by directory"},
        l = {":BufferOrderByLanguage<cr>", "order by language"}
        p = {":BufferPick<cr>", "Pick Buffer"},
        d = {":BufferOrderByDirectory<cr>", "Order by Directory"},
        l = {":BufferOrderByLanguage<cr>", "Order by Language"}
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
        b = {":Telescope buffers<cr>", "Buffers"}, -- create a binding with label
    },
    S = {
        name = "+Session",
        s = {":SessionSave<cr>", "save session"},
        l = {":SessionLoad<cr>", "load Session"}
    },
    f = {"<cmd>Neoformat<cr>", "Format File"},
    E = {"<cmd>NvimTreeFindFile<cr>", "Find Current file"},
    p = {"<cmd>Telescope find_files<cr>", "Find File"},
    r = {"<cmd>Telescope oldfiles<cr>", "Recent File"},
    R = {"<cmd>RnvimrToggle<cr>", "Ranger"},
}

wk.register(mappings, {prefix = "<leader>"})

return wk
