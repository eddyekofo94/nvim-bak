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
                "html",
                "javascript",
                "markdown",
                "yaml",
                "vim",
                "regex",
                "help",
                "json",
                "bash",
                "fish",
                "lua",
                "cpp",
                "python",
                "cpp",
                "java",
            },
            ignore_install = { "haskell" },
            sync_install = false,
            highlight = {
                disable = function()
                    return vim.b.large_buf
                end,
                enable = true, -- false will disable the whole extension
                use_languagetree = true,
            },
            autopairs = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
            },
            rainbow = {
                enable = true,
                disable = { "html" },
                extended_mode = false,
                max_file_lines = nil,
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
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
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
                        ["@function.outer"] = "V", -- linewise
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

        require("treesitter-context").setup({
            enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        })
    end,
}
