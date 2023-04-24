return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        plugins = { spelling = true },
    },
    config = function()
        require("which-key").setup({ plugins = { presets = { operators = false } } })
        local Util = require("utils")

        local wk = require("which-key")

        local leader_mappings = {
            b = {
                name = "+buffer",
                d = { ":BufferDelete<cr>", "Buffer delete" },
                e = { ":BufferLineSortByExtension<cr>", "sort by lang" },
                p = { ":BufferLinePick<cr>", "Pick Buffer" },
                x = { ":%bd|e#|bd#<cr>", "close all but current" },
            },
            c = {
                name = "+code",
                b = { ":Build<cr>", "Build code" },
                r = { ":Run<cr>", "Run code" },
                R = { ":RunAll<cr>", "Build&Run" },
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
                c = { ":Telescope current_buffer_fuzzy_find<cr>" , "search current buffer"},
                B = { ":Telescope git_branches<cr>", "git branches" },
                d = { ":Telescope lsp_document_diagnostics<cr>", "document_diagnostics" },
                D = {
                    ":Telescope lsp_workspace_diagnostics<cr>",
                    "workspace_diagnostics",
                },
                f = { ":Telescope frecency<cr>", "frecency" },
                h = { ":Telescope command_history<cr>", "history" },
                n = { ":NoiceTelescope<cr>", "noice" },
                m = { ":Telescope marks<cr>", "marks" },
                M = { ":Telescope man_pages<cr>", "man_pages" },
                o = { ":Telescope vim_options<cr>", "vim_options" },
                p = {
                    -- TODO: learn how to create projects
                    ":lua require'telescope'.extensions.project.project{}<cr>",
                    "projects",
                },
                R = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
                s = { Util.telescope("live_grep"), "string" },
                T = { ":TodoTelescope<cr>", "TODO" },
                r = { ":Telescope registers<cr>", "registers" },
                w = { ":Telescope file_browser<cr>", "file browser" },
                -- t = { ":Template ", "Create template" },
                u = { ":Telescope colorscheme<cr>", "colorschemes" },
                z = { ":Telescope zoxide list<cr>", "zoxide" },
            },
            S = {
                name = "+Session",
                r = {
                    ':lua require("persistence").load()<cr>',
                    "Restore Session",
                },
                l = {
                    ':lua require("persistence").load({ last = true })<cr>',
                    "Restore Last Session",
                },
                x = {
                    ':lua require("persistence").stop()<cr>',
                    "Don't Save Current Session",
                },
            },
            ["/"] = { ":CommentToggle<CR>", "comment" },
            ["\\"] = { "<cmd>Telescope pickers<cr>", "Searched History" },
            [":"] = { "<cmd>Telescope command_history<cr>", "Command History" },
            [" "] = { Util.telescope("files"), "Find File" },
            ["-"] = { ":FocusSplitDown<CR>", "split horizontally" },
            -- ["="] = { "<C-w>=", "balance windows" },
            ["="] = { ":FocusEqualise<cr>", "balance windows" },
            ["?"] = { ":NvimTreeFindFile<cr>", "find current file" },
            ["~"] = { ":NvimTreeRefresh<cr>", "refresh tree" },
            h = { ':let @/ = ""<cr>', "Clear Highlight" },
            -- H = { ":split", "Split bottom" },
            m = { ":FocusSplitCycle<cr>", "Move to next buffer" },
            M = { ":Mason<cr>", "Mason" },
            N = { ":Noice<cr>", "Noice" },
            F = { "<cmd>FormatWrite<cr>", "Format & Save File" },
            G = { "<cmd>LazyGit<cr>", "Lazygit" },
            e = { "Explorer" },
            L = { ":Lazy<cr>", "Lazy" },
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
            -- p = { ":Telescope find_files<cr>", "Find File" },
            P = {
                "<cmd>:lua require'telescope'.extensions.project.project{}<cr>",
                "Find Project",
            },
            r = { "<cmd>Telescope resume<cr>", "Resume search" },
            R = {
                name = "Refactor",
            },
            t = { ":FocusSplitNicely cmd term<cr>", "terminal" },
            T = { "<cmd>TodoQuickFix<cr>", "Search TODO" },
            U = { "<cmd>UndotreeShow<cr>", "Undotree show" },
            -- v = { "<C-W>v", "Split Right" },
            v = { ":FocusSplitNicely<cr>", "Split Right" },
            w = { ":FocusMaxOrEqual<cr>", "Max Window" },
            W = { "<C-W>q", "Close Window" },
            x = {
                name = "Debugger",
                b = {
                    function()
                        require("dap").toggle_breakpoint()
                    end,
                    "Toggle Breakpoint",
                },
                B = {
                    function()
                        require("dap").clear_breakpoints()
                    end,
                    "Clear Breakpoints",
                },
                c = {
                    function()
                        require("dap").continue()
                    end,
                    "Continue",
                },
                i = {
                    function()
                        require("dap").step_into()
                    end,
                    "Step Into",
                },
                -- g = {
                --     function()
                --         require("dap-go").debug_test()
                --         require("dapui").toggle()
                --     end,
                --     "Debug Go Test",
                -- },
                l = {
                    function()
                        require("dapui").float_element("breakpoints")
                    end,
                    "List Breakpoints",
                },
                o = {
                    function()
                        require("dap").step_over()
                    end,
                    "Step Over",
                },
                q = {
                    function()
                        require("dap").close()
                    end,
                    "Close Session",
                },
                Q = {
                    function()
                        require("dap").terminate()
                    end,
                    "Terminate",
                },
                r = {
                    function()
                        require("dap").repl.toggle()
                    end,
                    "REPL",
                },
                s = {
                    function()
                        require("dapui").float_element("scopes")
                    end,
                    "Scopes",
                },
                t = {
                    function()
                        require("dapui").float_element("stacks")
                    end,
                    "Threads",
                },
                u = {
                    function()
                        require("dapui").toggle()
                    end,
                    "Toggle Debugger UI",
                },
                w = {
                    function()
                        require("dapui").float_element("watches")
                    end,
                    "Watches",
                },
                x = {
                    function()
                        require("dap.ui.widgets").hover()
                    end,
                    "Inspect",
                },
            },
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
    end,
}
