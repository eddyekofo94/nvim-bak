return {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        -- code
        require("nvim-treesitter.configs").setup({
            --ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
            ensure_installed = {
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
            },
            ignore_install = { "haskell" },
            sync_install = false,
            highlight = {
                enable = true, -- false will disable the whole extension
                disable = function(_, bufnr)
                    if vim.api.nvim_buf_line_count(bufnr) > 50000 then
                        -- Disable in large number of line
                        return true
                    end

                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
                    if ok and stats and stats.size > 100 * 1024 then
                        -- Disable in large buffer size
                        return true
                    end
                end,
                use_languagetree = true,
            },
            matchup = {
                enable = true,
            },
            autopairs = {
                enable = true,
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
            autotag = {
                enable = true,
                disable = function()
                    return vim.b.large_buf
                end,
            },
            indent = { enable = true },
            refactor = {
                highlight_definitions = { enable = true },
                highlight_current_scope = { enable = false },
                smart_rename = {
                    enable = true,
                    keymaps = {
                        -- mapping to rename reference under cursor
                        smart_rename = "grr",
                    },
                },
            },
            textobjects = {
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
                    swap_next = { ["<leader>a"] = "@parameter.inner" },
                    swap_previous = { ["<leader>A"] = "@parameter.inner" },
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
