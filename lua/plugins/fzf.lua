-------------
-- Fzf Lua --
-------------
return {
    'ibhagwan/fzf-lua',
    event = 'VeryLazy',
    keys = {
        { '<leader>p', function() require('fzf-lua').files({}) end },
    },
    opts = {
        winopts = {
            width = 0.9,
            height = 0.8,
            hl = { border = 'SpecialKey' },
        },
        files = {
            prompt = '  > ',
            cmd = 'rg --hidden --files --ignore-file-case-insensitive ',
        },
        fzf_colors = {
            ['fg']      = { 'fg', 'Normal' },
            ['fg+']     = { 'fg', 'Question' },
            ['bg']      = { 'bg', 'Normal' },
            ['bg+']     = { 'bg', 'CursorLine' },
            ['hl']      = { 'fg', 'ErrorMsg' },
            ['hl+']     = { 'fg', 'ErrorMsg' },
            ['gutter']  = { 'bg', 'Normal' },
            ['pointer'] = { 'fg', 'Question' },
            ['marker']  = { 'fg', 'Title' },
            ['border']  = { 'fg', 'VisualNC' },
            ['header']  = { 'fg', 'WildMenu' },
            ['info']    = { 'fg', 'ErrorMsg' },
            ['spinner'] = { 'fg', 'Question' },
            ['prompt']  = { 'fg', 'Question' },
        },
        keymap = {
            fzf = {
                ['ctrl-p'] = 'previous-history',
                ['ctrl-n'] = 'next-history',
            },
        },
    },
}
