return {
    "folke/noice.nvim",
    lazy = false,
    config = function()
        require("noice").setup({
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = false,
                },
                signature = {
                    enabled = false,
                    auto_open = { enabled = false },
                },
            },
            views = {
                cmdline_popup = {
                    border = {
                        -- style = "none",
                        -- padding = { 1, 1 },
                    },
                    filter_options = {},
                    win_options = {
                        winhighlight = { NormalFloat = "NormalFloat", Normal = "Normal",
                            FloatBorder = "CursorLine" },
                    },
                },
            },
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        kind = "",
                    },
                    opts = { skip = true },
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true,         -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = false, -- long messages will be sent to a split
                inc_rename = true,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true,        -- add a border to hover docs and signature help
            },
            keys = {
                {
                    "<S-Enter>",
                    function()
                        require("noice").redirect(vim.fn.getcmdline())
                    end,
                    mode = "c",
                    desc = "Redirect Cmdline",
                },
                {
                    "<leader>snl",
                    function()
                        require("noice").cmd("last")
                    end,
                    desc = "Noice Last Message",
                },
                {
                    "<leader>snh",
                    function()
                        require("noice").cmd("history")
                    end,
                    desc = "Noice History",
                },
                {
                    "<leader>sna",
                    function()
                        require("noice").cmd("all")
                    end,
                    desc = "Noice All",
                },
                {
                    "<c-f>",
                    function()
                        if not require("noice.lsp").scroll(4) then
                            return "<c-f>"
                        end
                    end,
                    silent = true,
                    expr = true,
                    desc = "Scroll forward",
                    mode = { "i", "n", "s" },
                },
                {
                    "<c-b>",
                    function()
                        if not require("noice.lsp").scroll(-4) then
                            return "<c-b>"
                        end
                    end,
                    silent = true,
                    expr = true,
                    desc = "Scroll backward",
                    mode = { "i", "n", "s" },
                },
            },
        })
    end,
    dependencies = {
        {
            "rcarriga/nvim-notify",
            opts = {
                on_open = function(win)
                    vim.api.nvim_win_set_config(win, { focusable = false })
                end,
            },
        },
    },
}
