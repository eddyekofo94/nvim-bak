return {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
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
            },
            autotag = {
                enable = true,
                disable = function()
                    return vim.b.large_buf
                end,
            },
            indent = { enable = true },
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
                config = { c = "// %s", lua = "-- %s", vim = '" %s' },
            },
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
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        -- You can optionally set descriptions to the mappings (used in the desc parameter of
                        -- nvim_buf_set_keymap) which plugins like which-key display
                        ["ic"] = { query = "@class.inner", desc =
                        "Select inner part of a class region", },
                    },
                    -- You can choose the select mode (default is charwise 'v')
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * method: eg 'v' or 'o'
                    -- and should return the mode ('v', 'V', or '<c-v>') or a table
                    -- mapping query_strings to modes.
                    selection_modes = {
                        ["@parameter.outer"] = "v", -- charwise
                        ["@function.outer"] = "V",  -- linewise
                        ["@class.outer"] = "<c-v>", -- blockwise
                    },
                    -- If you set this to `true` (default is `false`) then any textobject is
                    -- extended to include preceding or succeeding whitespace. Succeeding
                    -- whitespace has priority in order to act similarly to eg the built-in
                    -- `ap`.
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * selection_mode: eg 'v'
                    -- and should return true of false
                    include_surrounding_whitespace = true,
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
