return {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
        require("catppuccin").setup({
            flavour = "mocha", -- mocha, macchiato, frappe, latte
            compile = { enabled = true, path = vim.fn.stdpath("cache") .. "/catppuccin" },
            custom_highlights = function(colors)
                return {
                    -- General
                    MatchParenCur            = { fg = colors.yellow, style = { "bold" } },
                    FloatBorder              = { fg = colors.surface0 }, -- TODO: this seems to not be working
                    WinSeparator             = { fg = colors.surface2 },
                    OverLength               = { fg = colors.red, bg = colors.base },

                    -- Telescope
                    TelescopeBorder          = { fg = colors.surface0 },
                    -- TScontext
                    TreesitterContextBottom  = {
                        sp = colors.surface0, -- INFO: don't know about this
                        style = { "bold", "italic" },
                    },

                    -- Neotree
                    NeoTreeDirectoryIcon  = { fg = colors.overlay1},

                    -- noice
                    NoiceCmdlinePopupBorder  = { fg = colors.overlay2 },
                    NoiceCmdlinePopupTitle   = { fg = colors.subtext0 },
                    -- navic
                    NavicText                = { fg = colors.subtext1 },
                    NavicSeparator           = { fg = colors.overlay0 },
                    -- cmp
                    CmpItemMenu              = { fg = colors.mauve },
                    CmpBorder                = { fg = colors.surface1 },
                    CmpItemKindSnippet       = { fg = colors.base, bg = colors.mauve },
                    CmpItemKindKeyword       = { fg = colors.base, bg = colors.red },
                    CmpItemKindText          = { fg = colors.base, bg = colors.teal },
                    CmpItemKindMethod        = { fg = colors.base, bg = colors.blue },
                    CmpItemKindConstructor   = { fg = colors.base, bg = colors.blue },
                    CmpItemKindFunction      = { fg = colors.base, bg = colors.blue },
                    CmpItemKindFolder        = { fg = colors.base, bg = colors.blue },
                    CmpItemKindModule        = { fg = colors.base, bg = colors.blue },
                    CmpItemKindConstant      = { fg = colors.base, bg = colors.peach },
                    CmpItemKindField         = { fg = colors.base, bg = colors.green },
                    CmpItemKindProperty      = { fg = colors.base, bg = colors.green },
                    CmpItemKindEnum          = { fg = colors.base, bg = colors.green },
                    CmpItemKindUnit          = { fg = colors.base, bg = colors.green },
                    CmpItemKindClass         = { fg = colors.base, bg = colors.yellow },
                    CmpItemKindVariable      = { fg = colors.base, bg = colors.flamingo },
                    CmpItemKindFile          = { fg = colors.base, bg = colors.blue },
                    CmpItemKindInterface     = { fg = colors.base, bg = colors.yellow },
                    CmpItemKindColor         = { fg = colors.base, bg = colors.red },
                    CmpItemKindReference     = { fg = colors.base, bg = colors.red },
                    CmpItemKindEnumMember    = { fg = colors.base, bg = colors.red },
                    CmpItemKindStruct        = { fg = colors.base, bg = colors.blue },
                    CmpItemKindValue         = { fg = colors.base, bg = colors.peach },
                    CmpItemKindEvent         = { fg = colors.base, bg = colors.blue },
                    CmpItemKindOperator      = { fg = colors.base, bg = colors.blue },
                    CmpItemKindTypeParameter = { fg = colors.base, bg = colors.blue },
                    CmpItemKindCopilot       = { fg = colors.base, bg = colors.teal },
                }
            end,
            term_colors = true,
            styles = {
                comments = { "italic" },
                strings = { "italic" },
            },
            integrations = {
                gitsigns = true,
                notify = true,
                noice = true,
                neogit = true,
                dashboard = true,
                telescope = { enabled = true, style = "nvchad" },
                which_key = true,
                treesitter = true,
                fidget = true,
                cmp = true,
                flash = true,
                treesitter_context = true,
                mason = true,
                harpoon = true,
                lsp_saga = true,
                navic = {
                    enabled = true,
                    custom_bg = "NONE",
                },
                dap = {
                    enabled = true,
                    enable_ui = true,
                },
                native_lsp = {
                    enabled = true,
                    inlay_hints = {
                        background = false,
                    },
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                },
            },
        })

        vim.cmd([[colorscheme catppuccin]])
        vim.cmd.highlight('DiagnosticUnderlineError gui=undercurl') -- use undercurl for error, if supported by terminal
    end,
    build = ":CatppuccinCompile",
    priority = 1000,
    enabled = true,
}
