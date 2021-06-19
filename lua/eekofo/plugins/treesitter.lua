require"nvim-treesitter.configs".setup {
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = {"haskell"},
    highlight = {
        enable = true, -- false will disable the whole extension
        use_languagetree = true
    },
    indent = {enable = true},
    context_commentstring = {
        enable = true,
        config = {c = "// %s", lua = "-- %s", vim = "\" %s"}
    },
    refactor = {
        highlight_definitions = {enable = true},
        highlight_current_scope = {enable = false},
        smart_rename = {
            enable = true,
            keymaps = {
                -- mapping to rename reference under cursor
                smart_rename = "grr"
            }
        }
    }
}
