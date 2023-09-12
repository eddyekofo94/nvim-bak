return {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = function()
        require('nvim-treesitter.install').update({ with_sync = true })()
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        -- code
        require("nvim-treesitter.configs").setup({
            --ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
            ensure_installed      = {
                "javascript",
                "markdown",
                "yaml",
                "vim",
                "go",
                "regex",
                "vimdoc",
                "json",
                "bash",
                "fish",
                "lua",
                "cpp",
                "dockerfile",
                "python",
                "cpp",
                "java",
                "gitcommit",
            },
            ignore_install        = { "haskell" },
            sync_install          = true,
            highlight             = {
                enable = true, -- false will disable the whole extension
                disable = function(_, bufnr)
                    if vim.api.nvim_buf_line_count(bufnr) > 50000 then
                        -- Disable in large number of line
                        return true
                    end
                end,
                use_languagetree = true,
            },
            matchup               = {
                enable = true,
                disable = function(_lang, buffer)
                    return vim.api.nvim_buf_line_count(buffer) > 20000
                end,
            },
            autopairs             = {
                enable = true,
            },
            query_linter          = {
                enable           = true,
                use_virtual_text = true,
                lint_events      = { "BufWrite", "CursorHold" },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
            autotag               = {
                enable = true,
                disable = function(buffer)
                    return vim.api.nvim_buf_line_count(buffer) > 20000
                end,
            },
            indent                = { enable = true },
            refactor              = {
                highlight_definitions = {
                    disable = function(lang, buffer)
                        local skip = { "help" }

                        return vim.api.nvim_buf_line_count(buffer) > 20000 or
                            vim.tbl_contains(skip, lang)
                    end,
                    clear_on_cursor_move = true,
                    smart_rename = {
                        enable  = true,
                        keymaps = {
                            smart_rename = "R",
                        },
                    },
                    enable = true,
                },
                highlight_current_scope = { enable = false },
                smart_rename = {
                    enable = true,
                    keymaps = {
                        -- mapping to rename reference under cursor
                        smart_rename = "grr",
                    },
                },
            },
            textobjects           = {
                select = {
                    enable = true,
                    lookahead = true, -- automatically jump forward to matching textobj
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        ["ib"] = "@block.inner",
                        ["ab"] = "@block.outer",
                        ["ir"] = "@parameter.inner",
                        ["ar"] = "@parameter.outer",
                    },
                },
                swap = {
                    enable = false,
                    swap_next = { ["<leader>na"] = "@parameter.inner" },
                    swap_previous = { ["<leader>nA"] = "@parameter.inner" },
                },
            },
        })

        -- Overwrite fold method using treesitter expression
        vim.opt.foldmethod = 'expr'
        vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

        require("treesitter-context").setup({
            enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        })
    end,
}
