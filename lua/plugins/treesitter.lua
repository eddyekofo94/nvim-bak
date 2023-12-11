return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPre",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-treesitter/nvim-treesitter-context",
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      init = function() end,
    },
    {
      "chrisgrieser/nvim-various-textobjs",
      lazy = false,
      opts = { useDefaultKeymaps = true },
    },
    "RRethy/nvim-treesitter-textsubjects",
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      config = function()
        require("ts_context_commentstring").setup({
          enable_autocmd = false,
          languages = {
            typescript = "// %s",
            javascript = "// %s",
            cpp = "// %s",
            fish = "# ",
            html = "<!-- ",
            query = "; ",
          },
        })
        vim.g.skip_ts_context_commentstring_module = true
      end,
    },
  },
  config = function()
    -- code
    require("nvim-treesitter.configs").setup({
      auto_install = true,
      modules = {},
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
        "gitcommit",
      },
      ignore_install = { "haskell" },
      sync_install = true,
      highlight = {
        enable = true, -- false will disable the whole extension
        disable = function(_, bufnr)
          if vim.api.nvim_buf_line_count(bufnr) > 50000 then
            -- Disable in large number of line
            return true
          end
        end,
        use_languagetree = true,
      },
      matchup = {
        enable = true,
        disable = function(_lang, buffer)
          return vim.api.nvim_buf_line_count(buffer) > 20000
        end,
      },
      autopairs = {
        enable = true,
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite" },
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
        disable = function(buffer)
          return vim.api.nvim_buf_line_count(buffer) > 20000
        end,
      },
      indent = {
        enable = true,
      },
      refactor = {
        highlight_definitions = {
          disable = function(lang, buffer)
            local skip = { "help" }

            return vim.api.nvim_buf_line_count(buffer) > 20000 or vim.tbl_contains(skip, lang)
          end,
          clear_on_cursor_move = true,
          smart_rename = {
            enable = true,
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
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]]"] = "@function.outer",
            ["]b"] = "@parameter.outer",
            ["]l"] = "@block.inner",
            ["]e"] = "@function.inner",
            ["]a"] = "@attribute.inner",
            ["]s"] = "@this_method_call",
            ["]c"] = "@method_object_call",
            ["]o"] = "@object_declaration",
            ["]k"] = "@object_key",
            ["]v"] = "@object_value",
            ["]w"] = "@method_parameter",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]B"] = "@parameter.outer",
            ["]L"] = "@block.inner",
            ["]E"] = "@function.inner",
            ["]A"] = "@attribute.inner",
            ["]S"] = "@this_method_call",
            ["]C"] = "@method_object_call",
            ["]O"] = "@object_declaration",
            ["]K"] = "@object_key",
            ["]V"] = "@object_value",
            ["]W"] = "@method_parameter",
          },
          goto_previous_start = {
            ["[["] = "@function.outer",
            ["[b"] = "@parameter.outer",
            ["[d"] = "@block.inner",
            ["[e"] = "@function.inner",
            ["[a"] = "@attribute.inner",
            ["[s"] = "@this_method_call",
            ["[c"] = "@method_object_call",
            ["[o"] = "@object_declaration",
            ["[k"] = "@object_key",
            ["[v"] = "@object_value",
            ["[w"] = "@method_parameter",
          },
          goto_previous_end = {
            ["[]"] = "@function.outer",
            ["[B"] = "@parameter.outer",
            ["[D"] = "@block.inner",
            ["[E"] = "@function.inner",
            ["[A"] = "@attribute.inner",
            ["[S"] = "@this_method_call",
            ["[C"] = "@method_object_call",
            ["[O"] = "@object_declaration",
            ["[K"] = "@object_key",
            ["[V"] = "@object_value",
            ["[W"] = "@method_parameter",
          },
        },
        swap = {
          enable = false,
          swap_next = { ["<leader>na"] = "@parameter.inner" },
          swap_previous = { ["<leader>nA"] = "@parameter.inner" },
        },
      },
      textsubjects = {
        enable = true,
        prev_selection = ",",
        keymaps = {
          ["."] = "textsubjects-smart",
          [";"] = "textsubjects-container-outer",
          ["i;"] = "textsubjects-container-inner",
        },
      },
    })

    local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
    local map = require("utils").keymap_set
    local nxo = require("utils").nxo

    -- Overwrite fold method using treesitter expression
    vim.opt.foldmethod = "expr"
    vim.treesitter.foldtext()
    -- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    -- example: make gitsigns.nvim movement repeatable with ; and , keys.
    local gs = require("gitsigns")

    -- make sure forward function comes first
    local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)

    -- map(nxo, ";", ts_repeat_move.repeat_last_move_next)
    -- map(nxo, ",", ts_repeat_move.repeat_last_move_previous)

    -- -- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.

    map(nxo, "]x", next_hunk_repeat, "git next hunk")
    map(nxo, "[x", prev_hunk_repeat, "git previous hunk")
  end,
}
