return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "neovim/nvim-lspconfig" }, -- Required
      { "williamboman/mason-lspconfig.nvim" }, -- Optional
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
          require("mason-tool-installer").setup({
            auto_update = true,
            debounce_hours = 24,
            ensure_installed = {
              "lua_ls",
              "vimls",
              "rust_analyzer",
              "yamlls",
              "gopls",
              "pylsp",
              "clangd",
              "bashls",
              "sqlls",
              "cmake",
              "gopls",
              "glint",
              "dockerls",
              "gopls",
              "glint",
            },
          })
        end,
      },
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        keys = {
          {
            "<leader>nn",
            "<cmd>Navbuddy<CR>",
            desc = "Navbuddy open",
          },
        },
        opts = { lsp = { auto_attach = true } },
        config = function()
          require("plugins.lsp.navbuddy")
        end,
      },
      {
        -- LSP VIRTUAL TEXT
        "Maan2003/lsp_lines.nvim",
        config = function()
          require("lsp_lines").setup()
          local keymap_set = require("utils").keymap_set
          keymap_set("n", "<Leader>dl", require("lsp_lines").toggle, "Toggle lsp_lines")
          -- disable virtual_text since it's redundant due to lsp_lines.
          vim.diagnostic.config({ virtual_text = false })
        end,
      },
      {
        "ray-x/go.nvim",
        dependencies = {
          "ray-x/guihua.lua",
          "nvim-treesitter/nvim-treesitter",
          "rafaelsq/nvim-goc.lua",
        },
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
        config = function()
          -- code
          require("plugins.lsp.go")
        end,
      },
      {
        "smjonas/inc-rename.nvim",
        config = true,
        -- keys = {
        --     {
        --         "<leader>lr",
        --         function()
        --             return "<cmd>IncRename " .. vim.fn.expand("<cword>")
        --         end,
        --         {
        --             expr = true,
        --             desc = "Rename",
        --         },
        --     }
        -- },
      },
      -- your lsp config or other stuff
      -- NOTE: not working as expected
      { "folke/neodev.nvim", config = true, lazy = true, ft = "lua" },
      "simrat39/rust-tools.nvim",
      "scalameta/nvim-metals", -- Java
      {
        "williamboman/mason.nvim",
        config = function()
          require("mason").setup()
        end,
      },
      {
        "folke/lsp-trouble.nvim",
        config = function()
          -- mapped to <space>lt -- this shows a list of diagnostics
          require("trouble").setup({
            height = 12, -- height of the trouble list
            mode = "document_diagnostics",
            action_keys = {
              -- key mappings for actions in the trouble list
              close = "q", -- close the list
              cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
              refresh = "r", -- manually refresh
              jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
              jump_close = { "o" }, -- jump to the diagnostic and close the list
              toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
              toggle_preview = "P", -- toggle auto_preview
              hover = "K", -- opens a small poup with the full multiline message
              preview = "p", -- preview the diagnostic location
              close_folds = { "zM", "zm" }, -- close all folds
              open_folds = { "zR", "zr" }, -- open all folds
              toggle_fold = { "zA", "za" }, -- toggle fold of current file
              previous = "k", -- preview item
              next = "j", -- next item
            },
          })
        end,
      },
    },
    config = function()
      -- INFO: this is where the configs are called
      require("plugins.lsp.nvim-lspconfig")
    end,
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {
      window = {
        relative = "editor",
      },
      text = { spinner = "dots_scrolling" },
      align = { bottom = true },
      fmt = { stack_upwards = false },
    },
  },
}
