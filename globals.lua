O = {
    auto_close_tree = 0,
    auto_complete = true,
    -- colorscheme = 'gruvbox',
    colorscheme = "gruvbox-material",
    hidden_files = true,
    wrap_lines = false,
    number = true,
    relative_number = true,
    shell = "fish",

    -- @usage pass a table with your desired languages

    treesitter = {
        ensure_installed = "maintained",
        ignore_install = { "haskell" },
        highlight = { enabled = true },
        playground = { enabled = false },
        rainbow = { enabled = false },
    },

    python = {
        linter = "",
        -- @usage can be 'yapf', 'black'
        formatter = "",
        autoformat = false,
        isort = false,
        diagnostics = { virtual_text = true, signs = true, underline = true },
    },
    dart = {
        sdk_path = "/usr/lib/dart/bin/snapshots/analysis_server.dart.snapshot",
    },
    lua = {
        -- @usage can be 'lua-format'
        formatter = "",
        autoformat = false,
        diagnostics = { virtual_text = true, signs = true, underline = true },
    },
    sh = {
        -- @usage can be 'shellcheck'
        linter = "",
        -- @usage can be 'shfmt'
        formatter = "",
        autoformat = false,
        diagnostics = { virtual_text = true, signs = true, underline = true },
    },
    tsserver = {
        -- @usage can be 'eslint'
        linter = "",
        -- @usage can be 'prettier'
        formatter = "",
        autoformat = false,
        diagnostics = { virtual_text = true, signs = true, underline = true },
    },
    json = {
        -- @usage can be 'prettier'
        formatter = "",
        autoformat = false,
        diagnostics = { virtual_text = true, signs = true, underline = true },
    },
    tailwindls = {
        filetypes = {
            "html",
            "css",
            "scss",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
        },
    },
    clang = {
        diagnostics = { virtual_text = true, signs = true, underline = true },
    },
    ruby = {
        diagnostics = { virtualtext = true, signs = true, underline = true },
        filetypes = { "rb", "erb", "rakefile" },
    },
    onedark_colors = {
        none = "NONE",
        bg2 = "#282c34",
        bg = "#21252b",
        bg_visual = "#393f4a",
        border = "#646e82",
        bg_highlight = "#2c313a",
        fg = "#abb2bf",
        fg_light = "#adbac7",
        fg_dark = "#798294",
        fg_gutter = "#5c6370",
        dark5 = "#abb2bf",
        blue = "#61afef",
        cyan = "#56b6c2",
        purple = "#c678dd",
        orange = "#d19a66",
        yellow = "#e0af68",
        yellow2 = "#e2c08d",
        bg_yellow = "#ebd09c",
        green = "#98c379",
        red = "#e86671",
        red1 = "#f65866",
        change = "#e0af68",
        add = "#109868",
        delete = "#9A353D",
    },
    gruvbox_colors = {
        bg = "#282828",
        bg1 = "#3c3836", -- cursor color
        bg2 = "#32302f",
        bg4 = "#45403d",
        bg5 = "#5a524c",
        fg = "#d4be98",
        fg1 = "#ddc7a1",
        red = "#ea6962",
        orange = "#e78a4e",
        yellow = "#d8a657",
        green = "#a9b665",
        aqua = "#89b482",
        blue = "#7daea3",
        purple = "#d3869b",
        bg_red = "#ea6962",
        bg_green = "#a9b665",
        bg_yellow = "#d8a657",
        grey0 = "#7c6f64",
        grey1 = "#928374",
        grey2 = "#a89984",
        white = "#f2e5bc",
        black = "#1d2021",
        none = "NONE",
        cyan = "#7daea3",
        pink = "#d3869b",
        link = "#89b482",
        cursor = "#ddc7a1",
    },
}
-- css = {formatter = '', autoformat = false, virtual_text = true},
-- json = {formatter = '', autoformat = false, virtual_text = true}

DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")

P = function(v)
    print(vim.inspect(v))
    return v
end

if pcall(require, "plenary") then
    RELOAD = require("plenary.reload").reload_module

    R = function(name)
        RELOAD(name)
        return require(name)
    end
end
