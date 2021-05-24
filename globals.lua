O = {
    auto_close_tree = 0,
    auto_complete = true,
    -- colorscheme = 'gruvbox',
    colorscheme = 'gruvbox-material.nvim',
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
        bg0 = "#282828",
        bg1 = "#32302f", -- cursor color
        bg2 = "#32302f",
        bg3 = "#45403d",
        bg4 = "#45403d",
        bg5 = "#5a524c",
        fg0 = "#d4be98",
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
        grey0 = '#7c6f64',
        grey1 = '#928374',
        grey2 = '#a89984',
        white = "#f2e5bc",
        black = '#1d2021',
        none = 'NONE',
        cyan = "#7daea3",
        pink = "#d3869b",
        link = "#89b482",
        cursor = "#ddc7a1"
    }

}
-- css = {formatter = '', autoformat = false, virtual_text = true},
-- json = {formatter = '', autoformat = false, virtual_text = true}

function ReloadConfig()
    print('Reloading config')
    require'plenary.reload'.reload_module('eekofo')
end

vim.api.nvim_set_keymap("n", "<leader><CR>", ":ReloadConfig()<cr>",
                        {expr = true})

DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

