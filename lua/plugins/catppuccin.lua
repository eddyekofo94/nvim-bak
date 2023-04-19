return {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
        vim.cmd([[colorscheme catppuccin]])
        local colors = require("catppuccin.palettes").get_palette() -- fetch colors from palette
        local normal = colors.text
        local fg, bg = normal.fg, normal.bg
        local bg_alt = colors.surface1
        local green = colors.green
        local red = colors.red
        require("catppuccin.lib.highlighter").syntax({
            TelescopeBorder = { fg = bg_alt, bg = bg },
            TelescopeNormal = { bg = bg },
            TelescopePreviewBorder = { fg = bg, bg = bg },
            TelescopePreviewNormal = { bg = bg },
            TelescopePreviewTitle = { fg = bg, bg = green },
            TelescopePromptBorder = { fg = bg_alt, bg = bg_alt },
            TelescopePromptNormal = { fg = fg, bg = bg_alt },
            TelescopePromptPrefix = { fg = red, bg = bg_alt },
            TelescopePromptTitle = { fg = bg, bg = red },
            TelescopeResultsBorder = { fg = bg, bg = bg },
            TelescopeResultsNormal = { bg = bg },
            TelescopeResultsTitle = { fg = bg, bg = bg },
        })
        if vim.g.colors_name == "catppuccin" then
            require("catppuccin").setup({
                flavour = "mocha", -- mocha, macchiato, frappe, latte
                term_colors = true,
                styles = {
                    comments = { "italic" },
                    strings = { "italic" },
                },
                integrations = {
                    gitsigns = true,
                    telescope = true,
                    neotree = true,
                    which_key = true,
                    treesitter = true,
                    fidget = true,
                    cmp = true,
                    ts_rainbow = true,
                    treesitter_context = true,
                    indent_blankline = {
                        enabled = false,
                        colored_indent_levels = false,
                    },
                    navic = {
                        enabled = true,
                        custom_bg = "NONE",
                    },
                    nvimtree = {
                        enabled = true,
                        show_root = false,
                    },
                    dap = {
                        enabled = true,
                        enable_ui = true,
                    },
                    native_lsp = {
                        enabled = true,
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
