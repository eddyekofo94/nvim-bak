local editor = require("catppuccin.groups.editor")
local catppucin = require("catppuccin")

catppucin.setup({
    flavour = "mocha", -- mocha, macchiato, frappe, latte
    term_colors = true,
    highlight_overrides = {
        all = function(colors)
            local normal = editor.get().Normal.fg
            local fg, bg = normal.fg, normal.bg
            local bg_alt = editor.get().Visual.bg
            local green = colors.green
            local red = colors.red
            return {
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
            }
        end,
    },
    integrations = {
        fidget = true,
        cmp = true,
        gitsigns = true,
        neotree = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
        navic = {
            enabled = true,
            custom_bg = "NONE",
        },
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
        },
    },
})

local mocha = O.catppuccin_colors
vim.cmd.highlight({ "Tabline", "guifg=" .. mocha.green, "guibg=" .. mocha.mantle })
