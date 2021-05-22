O = {
    auto_close_tree = 0,
    auto_complete = true,
    colorscheme = 'gruvbox',
    hidden_files = true,
    wrap_lines = false,
    number = true,
    relative_number = true,
    shell = 'fish',

    -- @usage pass a table with your desired languages

    treesitter = {
        ensure_installed = "maintained",
        ignore_install = {"haskell"},
        highlight = {enabled = true},
        playground = {enabled = false},
        rainbow = {enabled = false}
    },

    database = {save_location = '~/.config/nvcode_db', auto_execute = 1},
    python = {
        linter = '',
        -- @usage can be 'yapf', 'black'
        formatter = '',
        autoformat = false,
        isort = false,
        diagnostics = {virtual_text = true, signs = true, underline = true}
    },
    dart = {
        sdk_path = '/usr/lib/dart/bin/snapshots/analysis_server.dart.snapshot'
    },
    lua = {
        -- @usage can be 'lua-format'
        formatter = '',
        autoformat = false,
        diagnostics = {virtual_text = true, signs = true, underline = true}
    },
    sh = {
        -- @usage can be 'shellcheck'
        linter = '',
        -- @usage can be 'shfmt'
        formatter = '',
        autoformat = false,
        diagnostics = {virtual_text = true, signs = true, underline = true}
    },
    tsserver = {
        -- @usage can be 'eslint'
        linter = '',
        -- @usage can be 'prettier'
        formatter = '',
        autoformat = false,
        diagnostics = {virtual_text = true, signs = true, underline = true}
    },
    json = {
        -- @usage can be 'prettier'
        formatter = '',
        autoformat = false,
        diagnostics = {virtual_text = true, signs = true, underline = true}
    },
    tailwindls = {
        filetypes = {
            'html', 'css', 'scss', 'javascript', 'javascriptreact',
            'typescript', 'typescriptreact'
        }
    },
    clang = {
        diagnostics = {virtual_text = true, signs = true, underline = true}
    },
    ruby = {
        diagnostics = {virtualtext = true, signs = true, underline = true},
        filetypes = {'rb', 'erb', 'rakefile'}
    },
    gruvbox_colors = {
        dark0_hard = "#1d2021",
        bg = "#282828",
        dark0_soft = "#32302f",
        dark1 = "#3c3836",
        dark2 = "#504945",
        dark3 = "#665c54",
        dark4 = "#7c6f64",
        light0_hard = "#f9f5d7",
        light0 = "#fbf1c7",
        light0_soft = "#f2e5bc",
        light1 = "#ebdbb2",
        light2 = "#d5c4a1",
        light3 = "#bdae93",
        light4 = "#a89984",
        bright_red = "#fb4934",
        bright_green = "#b8bb26",
        bright_yellow = "#fabd2f",
        bright_blue = "#83a598",
        bright_purple = "#d3869b",
        bright_aqua = "#8ec07c",
        bright_orange = "#fe8019",
        red = "#cc241d",
        green = "#98971a",
        yellow = "#d79921",
        blue = "#458588",
        purple = "#b16286",
        aqua = "#689d6a",
        orange = "#d65d0e",
        faded_red = "#9d0006",
        faded_green = "#79740e",
        faded_yellow = "#b57614",
        faded_blue = "#076678",
        faded_purple = "#8f3f71",
        faded_aqua = "#427b58",
        faded_orange = "#af3a03",
        comment = "#928374",
        none = "NONE"
    }
    -- css = {formatter = '', autoformat = false, virtual_text = true},
    -- json = {formatter = '', autoformat = false, virtual_text = true}
}

function ReloadConfig()
    print('Reloading config')
    require'plenary.reload'.reload_module('eekofo')
end

vim.api.nvim_set_keymap("n", "<leader><CR>", ":ReloadConfig()<cr>",
                        {expr = true})

DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

