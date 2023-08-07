return {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
        vim.cmd([[colorscheme catppuccin]])
        vim.cmd.highlight('DiagnosticUnderlineError gui=undercurl') -- use undercurl for error, if supported by terminal

        local colors = require("catppuccin.palettes").get_palette() -- fetch colors from palette
        local normal = colors.text
        local fg, bg = normal.fg, normal.bg
        local bg_alt = colors.surface1
        local green = colors.green
        local red = colors.red
        require("catppuccin.lib.highlighter").syntax({
            TelescopeBorder          = { fg = bg_alt, bg = bg },
            TelescopeNormal          = { bg = bg },
            TelescopePreviewBorder   = { fg = bg, bg = bg },
            TelescopePreviewNormal   = { bg = bg },
            TelescopePreviewTitle    = { fg = bg, bg = green },
            TelescopePromptBorder    = { fg = bg_alt, bg = bg_alt },
            TelescopePromptNormal    = { fg = fg, bg = bg_alt },
            TelescopePromptPrefix    = { fg = red, bg = bg_alt },
            TelescopePromptTitle     = { fg = bg, bg = red },
            TelescopeResultsBorder   = { fg = bg, bg = bg },
            TelescopeResultsNormal   = { bg = bg },
            TelescopeResultsTitle    = { fg = bg, bg = bg },
            FloatBorder              = { fg = bg_alt, bg = bg },
            CmpItemMenu              = { fg = colors.blue },
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
        })
        if vim.g.colors_name == "catppuccin" then
            require("catppuccin").setup({
                flavour = "mocha", -- mocha, macchiato, frappe, latte
                compile = { enabled = true, path = vim.fn.stdpath("cache") .. "/catppuccin" },
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
                    which_key = true,
                    treesitter = true,
                    fidget = true,
                    cmp = true,
                    treesitter_context = true,
                    mason = true,
                    harpoon = true,
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
                            background = true,
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
        end
    end,
    build = ":CatppuccinCompile",
    priority = 1000,
    enabled = true,
}
